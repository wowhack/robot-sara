//
//  RSRecommendationsAPI.m
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRecommendationsAPI.h"
#import <AFNetworking.h>

NSString * const kRecommendationsAPIIP = @"10.47.12.108";
NSString * const kRecommendationsAPIPort = @"1027";

@implementation RSRecommendationsAPI

- (void)fetchRecommendations
{
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/recommendations",
                     kRecommendationsAPIIP,
                     kRecommendationsAPIPort];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        // Stub with some defaults for the time being
        NSString *artistName = @"Trophy Wife";
        NSString *sourceArtistName = @"Summer Heart";
        NSString *listensCount = @"12";
        
        if ([responseObject valueForKey:@"results"]) {
           NSDictionary *recommendations = [[[responseObject valueForKey:@"results"] valueForKey:@"recommendations"] objectAtIndex:0];
            
            artistName = [recommendations valueForKey:@"artistName"];
            sourceArtistName = [recommendations valueForKey:@"sourceArtistName"];
            listensCount = [recommendations valueForKey:@"listensCount"];
        }
        
        [self.delegate didFinishFetchingRecommendations:artistName sourceArtist:sourceArtistName listensCount:listensCount];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.delegate didFinishFetchingRecommendations:@"Trophy Wife" sourceArtist:@"Summer Heart" listensCount:@"12"];
    }];
}


@end
