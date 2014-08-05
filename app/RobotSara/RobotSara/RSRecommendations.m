//
//  RSRecommendations.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRecommendations.h"
#import "RSVocaliser.h"
#import "RSRoboticArm.h"

@implementation RSRecommendations

- (id)init {
    if (self = [super init]) {
        phrases = @[@"sarah can you recommend me some music",
                    @"sarah can you give me some recommendations",
                    @"can you recommend me music",
                    @"recommend music",
                    @"recommendations",
                    @"give me recommendations",
                    @"make some recommendations",
                    @"can you mix some recommendations"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSRecommendations");
    
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"led_on" seconds:2];
}

- (void)didFinishRoboticArmAction
{
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"Let me find some recommendations for you"];
}

- (void)didFinishSpeakingString
{
    [self.delegate didFinishActioningPhrase];
}

@end