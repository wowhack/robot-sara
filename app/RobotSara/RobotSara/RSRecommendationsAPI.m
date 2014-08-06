//
//  RSRecommendationsAPI.m
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRecommendationsAPI.h"

@implementation RSRecommendationsAPI

- (void)fetchRecommendations
{
    [self.delegate didFinishFetchingRecommendations:@"Trophy Wife" playCount:1];
}

@end
