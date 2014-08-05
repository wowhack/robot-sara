//
//  RSVocaliser.m
//  RobotSara
//
//  Created by Aaron Randall on 05/08/2014.
//  Copyright (c) 2014 AaronRandall. All rights reserved.
//

#import "RSVocaliser.h"

@implementation RSVocaliser {
    SKVocalizer *_vocalizer;
    BOOL _isSpeaking;
}

#pragma mark -
#pragma mark Actions

- (void)speak:(NSString*)phrase
{
    if (_isSpeaking) {
        [_vocalizer cancel];
        _isSpeaking = NO;
    }
    else {
        _isSpeaking = YES;
		// Initializes an english voice
        // _vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
        
		// Initializes a french voice
		// _vocalizer = [[SKVocalizer alloc] initWithLanguage:@"fr_FR" delegate:self];
		
		// Initializes a SKVocalizer with a specific voice
        _vocalizer = [[SKVocalizer alloc] initWithVoice:@"Samantha" delegate:self];
		
		// Speaks the string text
        [_vocalizer speakString:phrase];
        
        // Speaks the markup text with language For multiple languages, add <s></s> tags to markup string
		// NSString * textToReadString = [[[[NSString alloc] initWithCString:"<?xml version=\"1.0\"?> <speak version=\"1.0\" xmlns=\"http://www.w3.org/2001/10/synthesis\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.w3.org/2001/10/synthesis http://www.w3.org/TR/speech-synthesis/synthesis.xsd\" xml:lang=\"en-us\"> <s xml:lang=\"fr\"> "] stringByAppendingString:textToRead.text] stringByAppendingString:@"</s></speak>"];
		// [vocalizer speakMarkupString:textToReadString];
        
        // Speaks the markup text with voice, For multiple voices, add <voice></voice> tags to markup string.
		// NSString * textToReadString = [[[[NSString alloc] initWithCString:"<?xml version=\"1.0\"?> <speak version=\"1.0\" xmlns=\"http://www.w3.org/2001/10/synthesis\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.w3.org/2001/10/synthesis http://www.w3.org/TR/speech-synthesis/synthesis.xsd\" xml:lang=\"en-us\"> <voice name=\"Samantha\">"] stringByAppendingString:textToRead.text] stringByAppendingString:@"</voice></speak>"];
		// [vocalizer speakMarkupString:textToReadString];
        
		//textReadSoFar.text = @"";
    }
}


#pragma mark -
#pragma mark SpeechKitDelegate methods

- (void) destroyed {
    // Debug - Uncomment this code and fill in your app ID below, and set
    // the Main Window nib to MainWindow_Debug (in DMVocalizer-Info.plist)
    // if you need the ability to change servers in DMVocalizer
    //
    //[SpeechKit setupWithID:INSERT_YOUR_APPLICATION_ID_HERE
    //                  host:INSERT_YOUR_HOST_ADDRESS_HERE
    //                  port:INSERT_YOUR_HOST_PORT_HERE[[portBox text] intValue]
    //                useSSL:NO
    //              delegate:self];
}

#pragma mark -
#pragma mark SKVocalizerDelegate methods

- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text {
    _isSpeaking = YES;
}

- (void)vocalizer:(SKVocalizer *)vocalizer willSpeakTextAtCharacter:(NSUInteger)index ofString:(NSString *)text {
    NSLog(@"Session id [%@].", [SpeechKit sessionID]);
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error {
    NSLog(@"Session id [%@].", [SpeechKit sessionID]); // for debugging purpose: printing out the speechkit session id
    _isSpeaking = NO;
    //[speakButton setTitle:@"Read It" forState:UIControlStateNormal];
	if (error !=nil)
	{
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
														message:[error localizedDescription]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];*/
	}
    
    [self.delegate didFinishSpeakingString];
}


@end
