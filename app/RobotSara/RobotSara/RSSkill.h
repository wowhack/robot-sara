//
//  RSSkill.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSkill : NSObject

- (BOOL)canActionPhrase:(NSString*)phrase;
- (void)actionPhrase:(NSString*)phrase;

@end
