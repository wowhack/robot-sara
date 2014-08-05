//
//  RSBrain.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSBrainDelegate.h"
#import "RSSkillDelegate.h"

@interface RSBrain : NSObject<RSSkillDelegate>

- (BOOL)canActionPhrase:(NSString*)phrase;
- (void)actionPhrase:(NSString*)phrase;

@property (weak, nonatomic) id<RSBrainDelegate> delegate;

@end
