//
//  RSSleep.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSleep.h"
#import "RSVocaliser.h"
#import "RSRoboticArm.h"

@implementation RSSleep

- (id)init {
    if (self = [super init]) {
        phrases = @[@"go to sleep sarah",
                    @"go to sleep",
                    @"go sleep",
                    @"sleep"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSSleep");
    
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"Goodbye Aaron."];
}

- (void)didFinishSpeakingString
{
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"led_on" seconds:2];
}

- (void)didFinishRoboticArmAction
{
    [self.delegate didFinishActioningPhrase];
}

@end
