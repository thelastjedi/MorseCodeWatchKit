//
//  NotesPreviewCell.m
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "NotesPreviewCell.h"
#import "MCAppHelper.h"


@interface NotesPreviewCell()
@property (nonatomic, strong) NSString * noteContents;
@end
@implementation NotesPreviewCell


@synthesize notePreview;
@synthesize noteDateStamp;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundView  = nil;
        self.backgroundView  = [[UIView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        notePreview = [self labelForCell];
        notePreview.textColor = [UIColor blackColor];
        [self addSubview:notePreview];
        
        noteDateStamp = [self labelForCell];
        noteDateStamp.textAlignment = NSTextAlignmentRight;
        [self addSubview:noteDateStamp];
        
    }
    return self;
}

#pragma mark

-(void)loadCellForNote:(NSDictionary *)savedNote{
    
    for (NSString * date in savedNote) {
        self.noteContents   = savedNote[date];
        noteDateStamp.text  = [MCAppHelper getTimeStampFromDate:date];
        notePreview.text    = [self.noteContents substringToIndex:(self.noteContents.length < 10) ? self.noteContents.length : 10];
    }
}

-(NSString * )morseCode{
    return [MCAppHelper morseCodeFor:self.noteContents];
}

-(NSString * )fullText{
    return self.noteContents;
}

#pragma mark

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat xRef =  15;
    CGFloat fieldWidth  = CGRectGetWidth(self.contentView.bounds) - 2*xRef;
    CGFloat fieldHeight = CGRectGetHeight(self.contentView.bounds);
    
    self.notePreview.frame    =  CGRectMake(xRef, 0, fieldWidth*0.7, fieldHeight);
    self.noteDateStamp.frame  =  CGRectMake(xRef + CGRectGetMaxX(self.notePreview.frame), 0, fieldWidth*0.3, fieldHeight);
}

-(UILabel*)labelForCell{
    UIFont  * savedNoteFont   = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    UIColor * savedNoteColor  = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:0.5];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font          = savedNoteFont;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textColor     = savedNoteColor;
    label.numberOfLines = 1;

    return label;
}

@end