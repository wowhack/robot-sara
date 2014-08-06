//
//  RSWakeUpResponse.m
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSWakeUpResponse.h"
#import "RSVocaliser.h"

@implementation RSWakeUpResponse

- (id)init {
    if (self = [super init]) {
        // Currently only supports "good" responses, let's stay positive :)
        phrases = @[@"I'm good thank you sarah, how are you?",
                    @"how are you",
                    @"I'm good how you doing",
                    @"I'm good how are you",
                    @"I'm good thank you",
                    @"I'm good thanks",
                    @"good thanks"];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSWakeUpResponse");
    
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:@"I'm good thank you. Would you like to hear some new recommendations?"];
}

- (void)didFinishSpeakingString
{
    [self.delegate didFinishActioningPhrase];
}

@end
