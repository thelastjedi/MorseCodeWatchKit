//
//  NotesPreviewCell.h
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesPreviewCell : UITableViewCell

@property (nonatomic, strong) UILabel *notePreview;
@property (nonatomic, strong) UILabel *noteDateStamp;

-(void)loadCellForNote:(NSDictionary *)savedNote;

-(NSString*)morseCode;
-(NSString*)fullText;

@end
