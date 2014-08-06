//
//  RSRecommendationsAPI.h
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRecommendationsAPIDelegate.h"

@interface RSRecommendationsAPI : NSObject

- (void)fetchRecommendations;

@property (weak, nonatomic) id<RSRecommendationsAPIDelegate> delegate;

@end
