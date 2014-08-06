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
        phrases = @[@"sarah wake up",
                    @"wake up sarah",
                    @"wake up",
                    @"wake"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSWakeUp");
        
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"wake_up" seconds:0];
}

- (void)didFinishRoboticArmAction
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"SaraAppear"
     object:nil ];
    
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"Hi! How are you today Aaron."];
}

- (void)didFinishSpeakingString
{
    [self.delegate didFinishActioningPhrase];
}

@end
