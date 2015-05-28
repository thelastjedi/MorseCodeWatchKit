//
//  MorseHelper.h
//  MorseCode
//
//  Created by Harshita on 19/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import WatchKit;
@protocol MSHDelegate <NSObject>
-(void)updateTextLabel:(NSString*)text;
@end

typedef enum : NSUInteger {
    MC_Dot,
    MC_Dash,
    MC_Space
} MorseCodeInput;

@interface MorseHelper : NSObject

+ (id)sharedHelper;

/**
 *  We are currently not saving any text
 *
 *  So every click to 'Dits and Dahs' provides
 *  the user with a fresh slate
 */
- (void)reset;

/**
 *  User Input can be of three types: Dot, Dash, Space.
 *
 *  @param code MorseCodeInput
 */
- (void)inputReceived:(MorseCodeInput)code;

/**
 *  Hitherto entered morse code translated into English
 */
- (NSString*)fulltext;


@property (nonatomic, strong) id<MSHDelegate> msDelegate;

@end