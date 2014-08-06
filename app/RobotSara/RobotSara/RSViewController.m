//
//  RSViewController.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSViewController.h"
#import "RSBrain.h"
#import "RSAppDelegate.h"
#import <POP.h>

const unsigned char SpeechKitApplicationKey[] = {0x12, 0xb7, 0xd1, 0x90, 0xe6, 0x8d, 0x32, 0x46, 0x25, 0x85, 0x6f, 0x43, 0x67, 0x9e, 0xbe, 0x47, 0xde, 0x9c, 0x50, 0xcb, 0x1b, 0x2f, 0x4a, 0x38, 0x13, 0x59, 0x36, 0x6c, 0x51, 0x12, 0x99, 0x63, 0xc9, 0x6b, 0xf4, 0xaf, 0xf8, 0x26, 0xf5, 0x1d, 0xab, 0x65, 0x60, 0x13, 0x03, 0x1e, 0x5a, 0xe1, 0xbb, 0xaa, 0xac, 0xd6, 0xda, 0xf7, 0x0e, 0xed, 0x50, 0x44, 0x59, 0xa1, 0x56, 0xf3, 0x04, 0x20};

@interface RSViewController ()

@end

@implementation RSViewController {
    RSBrain *_brain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self addCircle];
    [self setupSpotifySessionStateChangeObserver];
    [self setupNotificationObservers];
    [self setupBrain];
    [self setupSpeechKit];
}

- (void)addCircle
{
    CGFloat lineWidth = 10.f;
    CGFloat radius = CGRectGetWidth(self.view.bounds)/4 - lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(85, 150, radius * 2, radius * 2);
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    
    self.circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:self.circleLayer];
    
    [self animateCircleTo:0.0f];
}

- (void)animateCircleTo:(float)point
{
    if (point > 0) {
        self.stateImage.hidden = NO;
    }
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(point);
    strokeAnimation.springBounciness = 20.f;
    strokeAnimation.springSpeed = 20.0f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    // Wait until Spotify has authenticated before starting to listen for audio,
    // otherwise they conflict with each other
    [self startRecording];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark RSBrainDelegate methods

- (void)didFinishActioningPhrase
{
    [self startRecording];
}

#pragma mark -
#pragma mark SKRecognizerDelegate methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording started.");
    
    transactionState = TS_RECORDING;
    [self displayStateChange];
    [self performSelector:@selector(updateAudioMeter) withObject:nil afterDelay:0.05];
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording finished.");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateAudioMeter) object:nil];
    [self setAudioMeterWidth:0.];
    
    transactionState = TS_PROCESSING;
    [self displayStateChange];
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    NSLog(@"Got results.");
    
    transactionState = TS_IDLE;
    [self displayStateChange];
    
    long numOfResults = [results.results count];
    
    if (numOfResults > 1) {
		self.suggestionsLabel.text = [[results.results subarrayWithRange:NSMakeRange(1, numOfResults-1)] componentsJoinedByString:@"\n"];
    }
    
    if (results.suggestion) {
        self.debugLabel.text = results.suggestion;
    }
    
    if (numOfResults > 0) {
        NSString *phrase = [results firstResult];
        self.resultsLabel.text = phrase;
        
        NSLog(@"Found phrase: %@", phrase);
        
        if ([_brain canActionPhrase:phrase]) {
            [_brain actionPhrase:phrase];
        } else {
            [self startRecording];
        }
    } else {
        [self startRecording];
    }
    
    voiceSearch = nil;
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Got error.");
    
    transactionState = TS_IDLE;
    [self displayStateChange];
    
    self.debugLabel.text = [error localizedDescription];
    
    if (suggestion) {
        self.debugLabel.text = suggestion;
    }
    
	voiceSearch = nil;
    
    [self startRecording];
}

#pragma mark -
#pragma mark Helper Methods

- (void)setupSpotifySessionStateChangeObserver
{
    RSAppDelegate *appDelegate = (RSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Listen for connection changes to the spotify session,
    // we can't start recording audio until it's connected
    [appDelegate addObserver:self
                  forKeyPath:@"spotifySession"
                     options:0
                     context:nil];
}

- (void)setupNotificationObservers
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"SaraAppear"
     object:nil ];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"SaraDisappear"
     object:nil ];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"PlayingAudio"
     object:nil ];
}

//event handler when event occurs
-(void)eventHandler: (NSNotification *) notification
{
    NSString *name = [notification name];
    if ([name isEqualToString:@"SaraAppear"]) {
        [self animateCircleTo:1.0f];
    } else if ([name isEqualToString:@"SaraDisappear"]) {
        [self animateCircleTo:0.0f];
        self.stateImage.hidden = YES;
    } else if ([name isEqualToString:@"PlayingAudio"]) {
        self.stateImage.image = [UIImage imageNamed:@"play"];
    }

    NSLog(@"event triggered");
}

- (void)setupBrain
{
    _brain = [RSBrain new];
    _brain.delegate = self;
}

- (void)setupSpeechKit
{
    [SpeechKit setupWithID:@"NMDPTRIAL_aaronrandall20140725125308"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:self];
}

- (void)startRecording
{
    if (!audioSwitch.on) {
        // If the switch is still off, don't start recording
        return;
    }
    
    // Need to dispatch the listening on the main thread after a delay, otherwise the Nuance lib crashes.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Started listening.");
        
        if (transactionState == TS_IDLE) {
            SKEndOfSpeechDetection detectionType;
            NSString* recoType;
            NSString* langType;
            
            transactionState = TS_INITIAL;
            [self displayStateChange];
            
            // Let's go with search speech detection for the time being
            detectionType = SKShortEndOfSpeechDetection;
            recoType = SKSearchRecognizerType;
            langType = @"en_GB";
            
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

#pragma mark -
#pragma mark UI Methods

-(IBAction)audioSwitch:(id)sender{
    
    if(audioSwitch.on) {
        [self startRecording];
    } else {
        [self stopRecording];
    }
}

- (void)displayStateChange
{
    NSString *stateText = @"";
    
    switch (transactionState) {
        case TS_IDLE:
            stateText = @"Idle";
            self.stateImage.image = [UIImage imageNamed:@"listen"];
            break;
        case TS_INITIAL:
            stateText = @"Initial";
            self.stateImage.image = [UIImage imageNamed:@"listen"];
            break;
        case TS_PROCESSING:
            stateText = @"Processing";
            self.stateImage.image = [UIImage imageNamed:@"think"];
            break;
        case TS_RECORDING:
            stateText = @"Recording";
            self.stateImage.image = [UIImage imageNamed:@"listen"];
        default:
            break;
    }
    
    self.stateLabel.text = stateText;
}

#pragma mark -
#pragma mark Audio Meter

- (void)setAudioMeterWidth:(float)width {
    if (width < 0)
        width = 0;
    
    self.audioLevelProgressView.progress = width;
}

- (void)updateAudioMeter {
    float width = (90 + voiceSearch.audioLevel)/100;
    
    [self setAudioMeterWidth:width];
    [self performSelector:@selector(updateAudioMeter) withObject:nil afterDelay:0.05];
}

@end