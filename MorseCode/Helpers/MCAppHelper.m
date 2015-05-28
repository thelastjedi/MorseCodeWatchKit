//
//  MCAppHelper.m
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "MCAppHelper.h"

#define kMCArchNotes @"MCArchivedNotes"

@interface MCAppHelper()
@end

@implementation MCAppHelper
@synthesize savedNotes;

+ (id)sharedHelper{
    static MCAppHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
        [sharedHelper initialiseArchivedNotes];
    });
    return sharedHelper;
}

#pragma mark - Public Methods

- (BOOL) updateSavedNotes:(NSDictionary*)newNote{
    
    if(![newNote isKindOfClass:[NSDictionary class]])
        return NO;
    
    if(!savedNotes){
        [self initialiseArchivedNotes];
    }
    
    [savedNotes insertObject:newNote atIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:MCRefreshTable object:nil];
    return YES;
}

+(NSString*)getTimeStampFromDate:(NSString*)dateString{

    NSDate   * now = [NSDate date];
    NSString * timeStampLabelText;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];

    NSDate *comparisonDate = [dateFormat dateFromString:dateString];
    
    [dateFormat setDateFormat:@"MMMM dd yyyy"];
    
    NSString * todayString     = [dateFormat stringFromDate:now];
    NSString * stampString     = [dateFormat stringFromDate:comparisonDate];
    NSString * yesterdayString = [dateFormat stringFromDate:[now dateByAddingTimeInterval:-24*60*60]];
    
    if([todayString isEqualToString:stampString]){
        [dateFormat setDateFormat:@"h:mm a"];
        timeStampLabelText = [dateFormat stringFromDate:comparisonDate];
    }
    else if([yesterdayString isEqualToString:stampString]){
        timeStampLabelText = @"Yesterday";
    }
    else{
        [dateFormat setDateFormat:@"dd MMM yyyy"];
        timeStampLabelText = [dateFormat stringFromDate:comparisonDate];
    }
    
    return timeStampLabelText;
}

+  (NSString*) morseCodeFor:(NSString*) originalText{

    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[originalText length]];
    
    [originalText enumerateSubstringsInRange:[originalText rangeOfString:originalText]
                                  options:NSStringEnumerationByComposedCharacterSequences
                               usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                   [characters addObject:[MCAppHelper codeForCharacter:substring]];
                                   [characters addObject:@" "];
                               }] ;
    
    return [[characters valueForKey:@"description"] componentsJoinedByString:@""];
}

#pragma mark - Settings

-(void)initialiseArchivedNotes{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:kMCArchNotes]){
        savedNotes = [NSMutableArray array];
    }
    else{
        savedNotes = [[NSUserDefaults standardUserDefaults] objectForKey:kMCArchNotes];
    }
}

-(void)archiveNotes{
    [[NSUserDefaults standardUserDefaults] setObject:savedNotes forKey:kMCArchNotes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark

+(NSString*)codeForCharacter:(NSString*)character{
    
    NSDictionary* morseCode = @{
                                @"a" : @"·−"    ,
                                @"b" : @"−···"  ,
                                @"c" : @"−·−·"  ,
                                @"d" : @"−··"   ,
                                @"e" : @"·"     ,
                                @"f" : @"··−·"  ,
                                @"g" : @"−−·"   ,
                                @"h" : @"····"  ,
                                @"i" : @"··"    ,
                                @"j" : @"·−−−"  ,
                                @"k" : @"−·−"   ,
                                @"l" : @"·−··"  ,
                                @"m" : @"−−"    ,
                                @"n" : @"−·"    ,
                                @"o" : @"−−−"   ,
                                @"p" : @"·−−·"  ,
                                @"q" : @"−−·−"  ,
                                @"r" : @"·−·"   ,
                                @"s" : @"···"   ,
                                @"t" : @"−"     ,
                                @"u" : @"··−"   ,
                                @"v" : @"···−"  ,
                                @"w" : @"·−−"   ,
                                @"x" : @"−··−"  ,
                                @"y" : @"−·−−"  ,
                                @"z" : @"−−··"  ,
                                @"0" : @"−−−−−" ,
                                @"1" : @"·−−−−" ,
                                @"2" : @"··−−−" ,
                                @"3" : @"···−−" ,
                                @"4" : @"····−" ,
                                @"5" : @"·····" ,
                                @"6" : @"−····" ,
                                @"7" : @"−−···" ,
                                @"8" : @"−−−··" ,
                                @"9" : @"−−−−·" ,
                                @" " : @"/"
                                };
    
    return (morseCode[character]) ? morseCode[character] : @"";
}


@end
