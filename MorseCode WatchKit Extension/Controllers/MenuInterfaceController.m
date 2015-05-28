//
//  MenuInterfaceController.m
//  MorseCode
//
//  Created by Harshita on 27/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "MenuInterfaceController.h"
#import "MorseHelper.h"

@implementation MenuInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
    [[MorseHelper sharedHelper] reset];
}

- (void)didDeactivate {
    [super didDeactivate];
}

@end