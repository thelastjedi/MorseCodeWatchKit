//
//  MCAppHelper.h
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MCRefreshTable @"RefreshSavedNotedTable"

@interface MCAppHelper : NSObject

+  (id)sharedHelper;

+  (NSString*)getTimeStampFromDate:(NSString*)dateString;
+  (NSString*)morseCodeFor:(NSString*) originalText;

- (BOOL)updateSavedNotes:(NSDictionary*)newNote;
- (void)deleteNoteAtIndex:(NSInteger)index;
- (void)archiveNotes;

@property (nonatomic, strong) NSMutableArray * savedNotes;


@end
