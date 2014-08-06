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
#import "RSSpotify.h"
#import "RSRecommendationsAPI.h"

@implementation RSRecommendations {
    NSString *_artist;
}

- (id)init {
    if (self = [super init]) {
        phrases = @[@"sarah can you recommend me some music",
                    @"sarah can you give me some recommendations",
                    @"can you recommend me music",
                    @"recommend music",
                    @"recommendations",
                    @"give me recommendations",
                    @"make some recommendations",
                    @"can you mix some recommendations for me",
                    @"can you mix some recommendations",];
    }
    return self;
}

- (void)actionPhrase:(NSString*)phrase
{
    NSLog(@"In Action Phrase for RSRecommendations");
    
    RSRoboticArm *roboticArm = [RSRoboticArm new];
    roboticArm.delegate = self;
    [roboticArm performAction:@"led_on" seconds:2];
    
    RSRecommendationsAPI *recommendations = [RSRecommendationsAPI new];
    recommendations.delegate = self;
    
    [recommendations fetchRecommendations];
}

- (void)didFinishFetchingRecommendations:(NSString *)artist playCount:(int)playCount
{
    _artist = artist;
    
    RSVocaliser *vocaliser = [RSVocaliser new];
    vocaliser.delegate = self;
    [vocaliser speak:[NSString stringWithFormat:@"I found a recommendation, %@. I'll play a popular track for you now", artist]];
}

- (void)didFinishRoboticArmAction
{
    NSLog(@"Robot arm movement finished");
}

- (void)didFinishSpeakingString
{
    // TODO: go to recommendations service for artist and play count
    RSSpotify *player = [RSSpotify new];
    player.delegate = self;
    [player playTrackByArtist:_artist];
}

- (void)didFinishPlayingTrack
{
    NSLog(@"Did finish playing Spotify track");
    [self.delegate didFinishActioningPhrase];
}

@end