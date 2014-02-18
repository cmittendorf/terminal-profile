//
//  TerminalColorSwitcher.m
//  SetTerminalStyle
//
//  Created by Christian Mittendorf on 31.10.09.
//  Copyright 2009 Christian Mittendorf. All rights reserved.
//

#import "TerminalColorSwitcher.h"
#import "NSString+Extras.h"

@implementation TerminalColorSwitcher
@synthesize title, style, terminal;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setTerminal:[SBApplication applicationWithBundleIdentifier:@"com.apple.Terminal"]];
    }
    return self;
}

- (void) dealloc
{
    [title release];
    [style release];
    [terminal release];
    [super dealloc];
}

- (void)applyStyle
{
    TerminalSettingsSet *tss = [self currentSettingsSet];
    TerminalTab *tab = [self currentTab];
    if (tab != nil)
    {
        if (tss != nil) 
        {
            [tab setCurrentSettings:tss];
        }
        if ([self title] != nil)
        {
            [tab setCustomTitle:[self title]];
        } else {
            [tab setCustomTitle:[tss customTitle]];
        }
    }
}

- (NSArray *)stylesArray
{
    return [[self terminal] settingsSets];
}

- (NSString *)currentStyle
{
    TerminalTab *tab = [self currentTab];
    if (tab != nil)
    {
        return [[tab currentSettings] name];
    } else {
        return nil;
    }
}

- (TerminalSettingsSet *)currentSettingsSet
{
    for (TerminalSettingsSet *s in [[self terminal] settingsSets])
    {
        if ([[s name] isEqualToString:[self style]])
        {
            return s;
        }
    }
    return nil;
}

- (TerminalTab *)currentTab
{
    NSString *tty = [self tty];
    for (TerminalWindow *w in [terminal windows])
    {
        for (TerminalTab *t in [w tabs])
        {
            if ([[t tty] isEqualToString:tty])
            {
                return t;
            }
        }
    }
    return nil;
}

- (NSString *)tty
{
    return [[NSString stringWithShellCommand:@"/usr/bin/tty"] chomp];
}

@end
