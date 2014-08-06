//
//  RSRecommendations.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSkill.h"
#import "RSVocaliserDelegate.h"
#import "RSRoboticArmDelegate.h"
#import "RSSpotifyDelegate.h"
#import "RSRecommendationsAPIDelegate.h"

@interface RSRecommendations : RSSkill<RSVocaliserDelegate, RSRoboticArmDelegate, RSSpotifyDelegate, RSRecommendationsAPIDelegate>

@end
