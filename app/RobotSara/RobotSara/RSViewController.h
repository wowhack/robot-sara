//
//  RSViewController.h
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>

@interface RSViewController : UIViewController<SpeechKitDelegate, SKRecognizerDelegate> {

    SKRecognizer* voiceSearch;
    
    enum {
        TS_IDLE,
        TS_INITIAL,
        TS_RECORDING,
        TS_PROCESSING,
    } transactionState;
}

@property(nonatomic,retain) IBOutlet UILabel* resultsLabel;
@property(nonatomic,retain) IBOutlet UILabel* stateLabel;
@property(nonatomic,retain) IBOutlet UILabel* debugLabel;
- (IBAction)recordButtonAction: (id)sender;

@end
