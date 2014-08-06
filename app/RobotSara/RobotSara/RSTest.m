//
//  RSTest.m
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSTest.h"
#import "RSVocaliser.h"
#import "RSRoboticArm.h"

@implementation RSTest

- (id)init {
    if (self = [super init]) {
        phrases = @[@"test",
                    @"test test",
                    @"testing",
                    @"testing testing",
                    @"this is a test"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSTest");
    
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"Testing testing 1 2 3"];
    
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"test" seconds:0];
}

- (void)didFinishSpeakingString
{
   [self.delegate didFinishActioningPhrase];
}

- (void)didFinishRoboticArmAction
{
   NSLog(@"Test of robot arm completed");  
}

@end
