//
//  RSRecommendationsAPIDelegate.h
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

@protocol RSRecommendationsAPIDelegate <NSObject>

- (void)didFinishFetchingRecommendations:(NSString*)artist sourceArtist:(NSString*)sourceArtist listensCount:(NSString*)listensCount;

@end