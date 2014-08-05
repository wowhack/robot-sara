//
//  RSRoboticArm.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSRoboticArmDelegate.h"

@interface RSRoboticArm : NSObject

- (void)performAction:(NSString*)action seconds:(float)seconds;

@property (weak, nonatomic) id<RSRoboticArmDelegate> delegate;

@end
