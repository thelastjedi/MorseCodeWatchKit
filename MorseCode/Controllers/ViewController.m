//
//  ViewController.m
//  MorseCode
//
//  Created by Harshita on 19/05/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Saved Notes";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.savedNotesTable setFrame:self.view.bounds];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable)
                                                 name:MCRefreshTable
                                               object:nil];
    
}

-(void)refreshTable{
    [self.savedNotesTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MCAppHelper sharedHelper] savedNotes] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"SavedNotesCell";
    NotesPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NotesPreviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell loadCellForNote:[[MCAppHelper sharedHelper] savedNotes][indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;  // 90/2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * dvc = [[DetailViewController alloc] init];
    dvc.selectedCell = (NotesPreviewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[MCAppHelper sharedHelper] deleteNoteAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
