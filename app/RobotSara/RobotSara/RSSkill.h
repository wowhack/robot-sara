//
//  RSSkill.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSSkillDelegate.h"

@interface RSSkill : NSObject {
    NSArray *phrases;
}

- (BOOL)canActionPhrase:(NSString*)phrase;
- (void)actionPhrase:(NSString*)phrase;

@property (weak, nonatomic) id<RSSkillDelegate> delegate;

@end
