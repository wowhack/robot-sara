//
//  RSSleep.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSleep.h"

@implementation RSSleep

- (BOOL)canActionPhrase:(NSString*)phrase
{
    return NO;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase");
}

@end
