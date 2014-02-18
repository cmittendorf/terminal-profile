//
//  SetTerminalStyle.m
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TerminalColorSwitcher.h"

void printUsage()
{
    printf("usage: SetTerminalStyle -s <style> [-t <title>] [-c]\n");
    printf("       SetTerminalStyle -l\n");
    printf("       SetTerminalStyle -c\n");
}

int main (int argc, char **argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    int ch;
    NSString *currentStyle = nil;

    if (argc == 1) {
        printUsage();
        [pool drain];
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
                [tcs setStyle:[NSString stringWithCString:optarg encoding:NSUTF8StringEncoding]];
                break;
            case 't':
                [tcs setTitle:[NSString stringWithCString:optarg encoding:NSUTF8StringEncoding]];
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
                [pool drain];
                return 0;
        }
    }
    
    [tcs applyStyle];
    
    if (currentStyle != nil)
        printf("%s", [currentStyle cStringUsingEncoding:NSUTF8StringEncoding]);
    
    [tcs release];
    
    [pool drain];
    return 0;
}
