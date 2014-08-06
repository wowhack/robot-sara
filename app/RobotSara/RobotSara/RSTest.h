//
//  RSTest.h
//  RobotSara
//
//  Created by Aaron Randall on 06/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSkill.h"
#import "RSVocaliserDelegate.h"
#import "RSRoboticArmDelegate.h"

@interface RSTest : RSSkill<RSVocaliserDelegate, RSRoboticArmDelegate>

@end