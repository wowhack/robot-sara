//
//  RSViewController.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSViewController.h"

const unsigned char SpeechKitApplicationKey[] = {0x12, 0xb7, 0xd1, 0x90, 0xe6, 0x8d, 0x32, 0x46, 0x25, 0x85, 0x6f, 0x43, 0x67, 0x9e, 0xbe, 0x47, 0xde, 0x9c, 0x50, 0xcb, 0x1b, 0x2f, 0x4a, 0x38, 0x13, 0x59, 0x36, 0x6c, 0x51, 0x12, 0x99, 0x63, 0xc9, 0x6b, 0xf4, 0xaf, 0xf8, 0x26, 0xf5, 0x1d, 0xab, 0x65, 0x60, 0x13, 0x03, 0x1e, 0x5a, 0xe1, 0xbb, 0xaa, 0xac, 0xd6, 0xda, 0xf7, 0x0e, 0xed, 0x50, 0x44, 0x59, 0xa1, 0x56, 0xf3, 0x04, 0x20};

@interface RSViewController ()

@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SpeechKit setupWithID:@"NMDPTRIAL_aaronrandall20140725125308"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:self];
    
    [self startRecording];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SKRecognizerDelegate methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording started.");
    
    transactionState = TS_RECORDING;
    //[recordButton setTitle:@"Recording..." forState:UIControlStateNormal];
    //[self performSelector:@selector(updateVUMeter) withObject:nil afterDelay:0.05];
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording finished.");
    
    //[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateVUMeter) object:nil];
    //[self setVUMeterWidth:0.];
    transactionState = TS_PROCESSING;
    //[recordButton setTitle:@"Processing..." forState:UIControlStateNormal];
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    NSLog(@"Got results.");
    NSLog(@"Session id [%@].", [SpeechKit sessionID]); // for debugging purpose: printing out the speechkit session id
    
    //long numOfResults = [results.results count];
    
    transactionState = TS_IDLE;
    //[recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
    //
    //    searchBox.text = [results firstResult];
    
	//if (numOfResults > 1)
	//	alternativesDisplay.text = [[results.results subarrayWithRange:NSMakeRange(1, numOfResults-1)] componentsJoinedByString:@"\n"];
    
    if (results.suggestion) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:results.suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    long numOfResults = [results.results count];
    if (numOfResults > 0) {
        self.resultsLabel.text = [results firstResult];
    }

	voiceSearch = nil;
    
    [self startRecording];
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Got error.");
    NSLog(@"Session id [%@].", [SpeechKit sessionID]); // for debugging purpose: printing out the speechkit session id
    
    transactionState = TS_IDLE;
    //[recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    if (suggestion) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
	voiceSearch = nil;
}

#pragma mark -
#pragma mark Actions

- (IBAction)recordButtonAction: (id)sender {
    [self startRecording];
}

#pragma mark -
#pragma mark Helper Methods

- (void)startRecording
{
    // Need to dispatch the listening on the main thread after a delay, otherwise
    // the Nuance lib crashes.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"STARTED LISTENING ON MAIN THREAD");
        self.resultsLabel.text = @"";
        
        if (transactionState == TS_IDLE) {
            SKEndOfSpeechDetection detectionType;
            NSString* recoType;
            NSString* langType;
            
            transactionState = TS_INITIAL;
            
            //alternativesDisplay.text = @"";
            
            // AR: let's go with search speech detection for the time being
            detectionType = SKShortEndOfSpeechDetection;
            recoType = SKSearchRecognizerType;
            langType = @"en_US";
            
            
            //NSLog(@"Recognizing type:'%@' Language Code: '%@' using end-of-speech detection:%d.", recoType, langType, detectionType);
            
            if (voiceSearch) {
                voiceSearch = nil;
            };
            
            voiceSearch = [[SKRecognizer alloc] initWithType:recoType
                                                   detection:detectionType
                                                    language:langType
                                                    delegate:self];
        }

    });
}

- (void)stopRecording
{
    if (transactionState == TS_RECORDING) {
        [voiceSearch stopRecording];
    }
}

@end
