//
//  RSWakeUp.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSWakeUp.h"

@implementation RSWakeUp

- (id)init {
    if (self = [super init]) {
        phrases = @[@"wake up",
                    @"wake"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSWakeUp");
}

@end
