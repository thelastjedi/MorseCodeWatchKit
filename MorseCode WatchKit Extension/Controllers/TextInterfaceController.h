//
//  TextInterfaceController.h
//  MorseCode
//
//  Created by Harshita on 20/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "MorseHelper.h"

@interface TextInterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *viewCompleteText;

@end
