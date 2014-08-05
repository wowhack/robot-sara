//
//  RSSkill.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSkill.h"
#import <StringScore/NSString+Score.h>

@implementation RSSkill

- (BOOL)canActionPhrase:(NSString*)phrase
{
    float matchingThreshold = 0.7f;
    
    for (NSString *supportedPhrase in phrases) {
        float matchingScore = [[phrase lowercaseString]
                               scoreAgainst:[supportedPhrase lowercaseString]
                               fuzziness:[NSNumber numberWithFloat:0.8]];
        if (matchingScore > matchingThreshold) {
            return YES;
        }
    }
    return NO;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase");
}

@end
