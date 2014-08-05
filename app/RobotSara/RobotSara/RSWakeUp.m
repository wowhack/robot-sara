//
//  RSWakeUp.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSWakeUp.h"
#import "RSVocaliser.h"
#import "RSRoboticArm.h"

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
    
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"led_on" seconds:2];
}

- (void)didFinishRoboticArmAction
{
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"Waking up"];
}

- (void)didFinishSpeakingString
{
    [self.delegate didFinishActioningPhrase];
}

@end
