//
//  MorseInterfaceController.m
//  MorseCode
//
//  Created by Harshita on 19/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "MorseInterfaceController.h"

@interface MorseInterfaceController ()<MSHDelegate>
@end

@implementation MorseInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [[MorseHelper sharedHelper] setMsDelegate:self];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

#pragma mark

- (IBAction)tapAction {
    [[MorseHelper sharedHelper] inputReceived:MC_Dash];
}

- (IBAction)dotAction {
    [[MorseHelper sharedHelper] inputReceived:MC_Dot];
}

- (IBAction)spaceAction {
    [[MorseHelper sharedHelper] inputReceived:MC_Space];
}

#pragma mark - MSHDelegate

-(void)updateTextLabel:(NSString*)text{
    [self.displayLabel setText:text];
}

#pragma mark - WKInterfaceMenu

- (IBAction)viewText {
    [self presentControllerWithName:@"TextInterface" context:nil];
}

@end
