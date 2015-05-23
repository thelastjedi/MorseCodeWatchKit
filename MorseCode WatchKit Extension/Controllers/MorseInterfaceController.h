//
//  MorseInterfaceController.h
//  MorseCode
//
//  Created by Harshita on 19/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "MorseHelper.h"

@interface MorseInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceButton *tapButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *displayLabel;

@end
