//
//  RSWakeUp.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSWakeUp.h"
#import "RSVocaliser.h"

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
    // Tell the robot arm to get up
    // Speak welcome text
    RSVocaliser *vocaliser = [RSVocaliser new];
    [vocaliser speak:@"Waking up"];
    
    NSLog(@"In Action Phrase for RSWakeUp");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate didFinishActioningPhrase];
    });
}

@end
