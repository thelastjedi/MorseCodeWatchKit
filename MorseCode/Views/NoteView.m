//
//  NoteView.m
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "NoteView.h"

@interface NoteView()
@property (nonatomic, strong) UITextView * noteTextView;
@end

@implementation NoteView
@synthesize noteTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (nil != self) {
        
        self.clipsToBounds = YES;
        
        CGFloat roundedCornerRadius = 15.0f;
        
        UIBezierPath *topMaskPath;
        topMaskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(roundedCornerRadius, roundedCornerRadius)];
        
        CAShapeLayer *topMask = [[CAShapeLayer alloc] init];
        [topMask setFrame: self.bounds];
        [topMask setPath: topMaskPath.CGPath];
        self.layer.mask = topMask;
        
        self.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
        
        UIFont  * noteFont   = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
        UIColor * noteColor  = [UIColor blackColor];

        noteTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        noteTextView.backgroundColor = [UIColor clearColor];
        noteTextView.editable        = NO;
        noteTextView.font            = noteFont;
        noteTextView.textColor       = noteColor;
        noteTextView.textContainerInset  = UIEdgeInsetsZero;
        [self addSubview:noteTextView];
    }
    return self;
}

-(void)updateText:(NSString*)text{
    noteTextView.text = text;
}

-(void)layoutSubviews{
    noteTextView.frame = CGRectInset(self.bounds, 10, 10);
}

@end
