//
//  RSBrain.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSBrain.h"
#import "RSSkill.h"
#import "RSWakeUp.h"
#import "RSSleep.h"

@implementation RSBrain {
    NSArray *_skills;
}

- (id)init {
    if (self = [super init]) {
        _skills = @[[RSWakeUp new],
                    [RSSleep new]];
    }
    return self;
}

- (BOOL)canActionPhrase:(NSString*)phrase
{
    // If we can find a skill that supports the current
    // phrase, then we can perform an action for the phrase
    if ([self skillForPhrase:phrase] != nil) {
        return YES;
    }
    return NO;
}

- (void)actionPhrase:(NSString*)phrase
{
    // Action the phrase using the specified skill
    RSSkill *skill = [self skillForPhrase:phrase];
    [skill actionPhrase:phrase];
}

- (RSSkill*)skillForPhrase:(NSString*)phrase
{
    // Check each skill to see if the skill supports
    // the phrase, and return the first match
    for (RSSkill *skill in _skills) {
        if ([skill canActionPhrase:phrase]) {
            return skill;
        }
    }
    
    return nil;
}

@end