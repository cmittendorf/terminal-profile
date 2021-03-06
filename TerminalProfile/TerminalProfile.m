//
//  SetTerminalStyle.m
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

@import Foundation;

#import "TerminalColorSwitcher.h"

void printUsage()
{
    printf("usage: terminal-profile -s <profile> [-t <title>] [-c]\n");
    printf("       terminal-profile -l\n");
    printf("       terminal-profile -c\n");
}

int main (int argc, char **argv)
{
    @autoreleasepool {
        int ch;
        NSString *currentStyle = nil;
        
        if (argc == 1) {
            printUsage();
            return 0;
        }
        
        TerminalColorSwitcher *tcs = [[TerminalColorSwitcher alloc] init];
        
        while ( (ch = getopt(argc, argv, ":s:t:lch")) != -1 )
        {
            switch (ch)
            {
                case 'c':
                    currentStyle = [tcs currentStyle];
                    break;
                case 's':
                    tcs.style = @(optarg);
                    break;
                case 't':
                    tcs.title = @(optarg);
                    break;
                case 'l':
                    for (TerminalSettingsSet *s in [tcs stylesArray])
                    {
                        if ([[s name] isEqualToString:[tcs currentStyle]] == YES) {
                            printf("%s *\n", [[s name] cStringUsingEncoding:NSUTF8StringEncoding]);
                        } else {
                            printf("%s\n", [[s name] cStringUsingEncoding:NSUTF8StringEncoding]);
                        }
                    }
                    break;
                default:
                    printUsage();
                    return 0;
            }
        }
        
        [tcs applyStyle];
        
        if (currentStyle != nil)
            printf("%s", [currentStyle cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    return 0;
}
