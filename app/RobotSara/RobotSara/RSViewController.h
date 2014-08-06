//
//  RSViewController.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>
#import "RSBrainDelegate.h"

@interface RSViewController : UIViewController<SpeechKitDelegate, SKRecognizerDelegate, RSBrainDelegate> {

    SKRecognizer* voiceSearch;
    IBOutlet UISwitch *audioSwitch;
    
    enum {
        TS_IDLE,
        TS_INITIAL,
        TS_RECORDING,
        TS_PROCESSING,
    } transactionState;
}

@property(nonatomic,retain) IBOutlet UIImageView* stateImage;
@property(nonatomic,retain) IBOutlet UILabel* resultsLabel;
@property(nonatomic,retain) IBOutlet UILabel* suggestionsLabel;
@property(nonatomic,retain) IBOutlet UILabel* stateLabel;
@property(nonatomic,retain) IBOutlet UILabel* debugLabel;
@property(nonatomic,retain) IBOutlet UIProgressView* audioLevelProgressView;

@property(nonatomic) CAShapeLayer *circleLayer;

@end
