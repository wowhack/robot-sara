//
//  RSRoboticArm.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRoboticArm.h"
#import <AFNetworking.h>

@implementation RSRoboticArm

NSString * const kRoboticArmIP = @"10.47.12.70";
NSString * const kRoboticArmPort = @"1025";

- (void)performAction:(NSString*)action seconds:(float)seconds
{
    NSString *url = [NSString stringWithFormat:@"%@:%@/?action=%@&seconds=%f",
                     kRoboticArmIP,
                     kRoboticArmPort,
                     action,
                     seconds];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.delegate didFinishRoboticArmAction];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.delegate didFinishRoboticArmAction];
    }];
}

@end
