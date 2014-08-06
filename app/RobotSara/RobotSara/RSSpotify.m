//
//  RSSpotify.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSpotify.h"
#import "RSAppDelegate.h"

@implementation RSSpotify

- (void)playTrackByArtist:(NSString*)artist
{
    RSAppDelegate *appDelegate = (RSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.spotifySession isValid])
    {
        [SPTRequest performSearchWithQuery:artist queryType:SPTQueryTypeAlbum session:appDelegate.spotifySession callback:^(NSError *error, id object) {
            NSLog(@"IN CALLBACK");
            
            if (error == nil && object != nil) {
                SPTPartialAlbum *album = [[object items] objectAtIndex:0];
                if (album) {
                    [self playTrackFromAlbum:album];
                }
            }
        }];
     }
}

- (void)playTrackFromAlbum:(SPTPartialAlbum*)partialAlbum
{
    RSAppDelegate *appDelegate = (RSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.spotifySession isValid])
    {
    
        // Create a new track player if needed
        if (appDelegate.trackPlayer == nil) {
            appDelegate.trackPlayer = [[SPTTrackPlayer alloc] initWithCompanyName:@"Your-Company-Name"
                                                                          appName:@"Your-App-Name"];
        }
        
        [appDelegate.trackPlayer enablePlaybackWithSession:appDelegate.spotifySession callback:^(NSError *error) {
            
            if (error != nil) {
                NSLog(@"*** Enabling playback got error: %@", error);
                return;
            }
            
            [SPTRequest requestItemAtURI:partialAlbum.uri
                             withSession:nil
                                callback:^(NSError *error, SPTAlbum *album) {
                                    
                                    if (error != nil) {
                                        NSLog(@"*** Album lookup got error %@", error);
                                        return;
                                    }
                                    
                                    [appDelegate.trackPlayer playTrackProvider:album fromIndex:6];
                                    [self performSelector:@selector(stopPlayingTrack)
                                                      withObject:nil afterDelay:25];
                                }];
        }];
    }
}

- (void)stopPlayingTrack
{
    RSAppDelegate *appDelegate = (RSAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.trackPlayer pausePlayback];
    [self.delegate didFinishPlayingTrack];
}

@end
