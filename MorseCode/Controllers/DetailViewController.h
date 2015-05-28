//
//  DetailViewController.h
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesPreviewCell.h"


@interface DetailViewController : UIViewController

@property (nonatomic, strong) NotesPreviewCell * selectedCell;

@end
