//
//  NSString+Extras.m
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

#import "NSString+Extras.h"


@implementation NSString(NSStringExtras)

+ (NSString *)stringWithShellCommand:(NSString *)command
{
    NSTask *task = [NSTask new];
    [task setLaunchPath:command];
    NSPipe *output = [NSPipe new];
    [task setStandardOutput:output];
    [task launch];
    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

- (NSString *)chomp
{
    int lastIndex = [self length] - 1;
    if (lastIndex >= 0)
    {
        if ([self characterAtIndex:lastIndex] == 10)
        {
            return [self substringWithRange:NSMakeRange(0, lastIndex)];
        } else {
            return self;
        }
    } else {
        return self;
    }
}

@end
