//
//  DetailViewController.m
//  MorseCode
//
//  Created by Harshita on 28/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "DetailViewController.h"
#import "NoteView.h"
@interface DetailViewController (){
    NoteView * note;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutomaticallyAdjustsScrollViewInsets: NO];

    note = [[NoteView alloc] initWithFrame:CGRectMake(20, 84, CGRectGetWidth(self.view.frame) - 40, CGRectGetHeight(self.view.frame) - 84)];
    [self.view addSubview:note];
    
    [note updateText:[self.selectedCell fullText]];
    
    [self addToggleButton];
}

#pragma mark

-(void)addToggleButton{
    UIBarButtonItem *toggleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"⚫︎"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(toggleTranslateButton:)];
    self.navigationItem.rightBarButtonItem = toggleButtonItem;
    [toggleButtonItem setTag:0];
}

-(void)toggleTranslateButton:(id)sender{

    if([(UIBarButtonItem*)sender tag] == 0){
        [note updateText:[self.selectedCell morseCode]];
        [(UIBarButtonItem*)sender setTitle:@"T"];
        [(UIBarButtonItem*)sender setTag:1];
    }
    else{
        [note updateText:[self.selectedCell fullText]];
        [(UIBarButtonItem*)sender setTitle:@"⚫︎"];
        [(UIBarButtonItem*)sender setTag:0];
    }
}

#pragma mark

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
