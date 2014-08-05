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

+ (void)play
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
            
            [SPTRequest requestItemAtURI:[NSURL URLWithString:@"spotify:album:4L1HDyfdGIkACuygktO7T7"]
                             withSession:nil
                                callback:^(NSError *error, SPTAlbum *album) {
                                    
                                    if (error != nil) {
                                        NSLog(@"*** Album lookup got error %@", error);
                                        return;
                                    }
                                    
                                    [appDelegate.trackPlayer playTrackProvider:album];
                                    
                                }];
        }];
    }
    
}

@end
