//
//  TerminalColorSwitcher.h
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terminal.h"

@class TerminalApplication, TerminalWindow, TerminalSettingsSet, TerminalTab;

@interface TerminalColorSwitcher : NSObject {
    NSString *title;
    NSString *style;
    
    TerminalApplication *terminal;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *style;
@property (nonatomic, retain) TerminalApplication *terminal;
- (void)applyStyle;
- (NSArray *)stylesArray;
- (NSString *)currentStyle;
- (TerminalSettingsSet *)currentSettingsSet;
- (TerminalTab *)currentTab;
- (NSString *)tty;
@end
