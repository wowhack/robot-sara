//
//  RSSpotify.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Spotify/Spotify.h>
#import "RSSpotifyDelegate.h"

@interface RSSpotify : NSObject

- (void)playTrackByArtist:(NSString*)artist;
- (void)stopPlayingTrack;

@property (weak, nonatomic) id<RSSpotifyDelegate> delegate;

@end
