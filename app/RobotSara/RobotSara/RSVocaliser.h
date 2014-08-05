//
//  RSVocaliser.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>
#import "RSVocaliserDelegate.h"

@interface RSVocaliser : NSObject<SpeechKitDelegate, SKVocalizerDelegate>

- (void)speak:(NSString*)phrase;

@property (weak, nonatomic) id<RSVocaliserDelegate> delegate;

@end
