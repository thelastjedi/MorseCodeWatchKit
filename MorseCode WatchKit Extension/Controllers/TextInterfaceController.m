//
//  TextInterfaceController.m
//  MorseCode
//
//  Created by Harshita on 20/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "TextInterfaceController.h"

@interface TextInterfaceController ()

@end

@implementation TextInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.viewCompleteText setText:[[MorseHelper sharedHelper] fulltext]];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

@end



