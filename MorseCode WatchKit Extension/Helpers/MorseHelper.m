//
//  MorseHelper.m
//  MorseCode
//
//  Created by Harshita on 19/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "MorseHelper.h"
#define kMCDelayKey @"MorseCodeDelayKey"

@interface MorseHelper()

@property (nonatomic, strong) NSDate * lastTapped;

@property (nonatomic, strong) NSMutableString * words;
@property (nonatomic, strong) NSMutableString * sentence;

@property (nonatomic, assign) NSTimeInterval durationBetweenWords;

@end

@implementation MorseHelper
@synthesize words;
@synthesize sentence;


+ (id)sharedHelper
{
    static MorseHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
        [sharedHelper reset];
    });
    return sharedHelper;
}

#pragma mark - Public Methods

- (void)reset{
    self.sentence = [[NSMutableString alloc] initWithString:@""];
    self.words = nil;
}

- (void)inputReceived:(MorseCodeInput)code{
    
    if(([self isNewCharacter])||(code == MC_Space)){
        [self.sentence appendString:[self updateTranslatedText]];
    }
    
    if (code == MC_Space) {
        [self.sentence appendString:@" "];
        return;
    }
    
    if(!words)
        words = [[NSMutableString alloc] initWithString:@""];

    [words appendString: (code == MC_Dot) ? @"·" : @"−"];

}

-(NSString*)fulltext{
    if(words){
        [self.sentence appendString:[self updateTranslatedText]];
    }
    return [NSString stringWithFormat:@"%@", sentence];
}

#pragma mark - Private Methods

-(NSString*)updateTranslatedText{
    NSString * newChar = [self translationForCode:words];
    [self updateViewWithText:newChar];
    words = nil;
    return newChar;
}


-(BOOL)isNewCharacter{
    NSDate * now = [NSDate date];

    if (!self.lastTapped) {
        self.lastTapped = now;
        return NO;
    }
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:self.lastTapped];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:now];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitSecond
                                               fromDate:self.lastTapped toDate:now options:0];

    self.lastTapped = now;
    return ([difference second] >= [self getDelay]);
}

#pragma mark - Settings

-(NSTimeInterval)getDelay{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:kMCDelayKey]){
        return 1;
    }
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kMCDelayKey] integerValue];
}

-(void)setDelay:(NSTimeInterval)delayTimeInterval{
    [[NSUserDefaults standardUserDefaults] setObject:@(delayTimeInterval) forKey:kMCDelayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Delegate

-(void)updateViewWithText:(NSString*)msg{
    if([self.msDelegate respondsToSelector:@selector(updateTextLabel:)]){
        [self.msDelegate updateTextLabel:msg];
    }
}

#pragma mark

-(NSString*)translationForCode:(NSString*)code{
    
    NSDictionary* morseCode = @{
                                @"·−"    : @"a",
                                @"−···"  : @"b",
                                @"−·−·"  : @"c",
                                @"−··"   : @"d",
                                @"·"     : @"e",
                                @"··−·"  : @"f",
                                @"−−·"   : @"g",
                                @"····"  : @"h",
                                @"··"    : @"i",
                                @"·−−−"  : @"j",
                                @"−·−"   : @"k",
                                @"·−··"  : @"l",
                                @"−−"    : @"m",
                                @"−·"    : @"n",
                                @"−−−"   : @"o",
                                @"·−−·"  : @"p",
                                @"−−·−"  : @"q",
                                @"·−·"   : @"r",
                                @"···"   : @"s",
                                @"−"     : @"t",
                                @"··−"   : @"u",
                                @"···−"  : @"v",
                                @"·−−"   : @"w",
                                @"−··−"  : @"x",
                                @"−·−−"  : @"y",
                                @"−−··"  : @"z",
                                @"−−−−−" : @"0",
                                @"·−−−−" : @"1",
                                @"··−−−" : @"2",
                                @"···−−" : @"3",
                                @"····−" : @"4",
                                @"·····" : @"5",
                                @"−····" : @"6",
                                @"−−···" : @"7",
                                @"−−−··" : @"8",
                                @"−−−−·" : @"9",
                                };
    
    return (morseCode[code]) ? morseCode[code] : @"";
}

@end