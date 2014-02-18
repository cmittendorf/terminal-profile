//
//  NSString+Extras.h
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(NSStringExtras)
+ (NSString *)stringWithShellCommand:(NSString *) command;
- (NSString *)chomp;
@end
