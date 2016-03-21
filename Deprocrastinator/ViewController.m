//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Dylan Bruschi on 3/21/16.
//  Copyright © 2016 Dylan Bruschi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOutlet;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSMutableArray *tasks;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 50; i++) {
        self.tasks[i] = [NSString stringWithFormat:@"Row %i",i];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tasks.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
//    if ([self.editButton.currentTitle isEqualToString: @"Done"]) {
//        cell.textLabel.textColor = [UIColor blackColor];
//        [self.tasks removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:YES];
//        [self.tableView reloadData];
//    }
    
}


- (IBAction)onAddButtonPressed:(id)sender {
    
    NSString *task = self.textFieldOutlet.text;
    [self.tasks addObject:task];
    [self.tableView reloadData];
    self.textFieldOutlet.text = @"";
    [self.view endEditing:YES];
}

- (IBAction)onEditButtonPressed:(UIButton*)sender {
    
    [self.tableView setEditing:YES animated:YES];
    
    if ([sender.currentTitle isEqualToString:@"Edit"]) {
    [sender setTitle:@"Done" forState:UIControlStateNormal];
    }
    else {
    [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
  
    

if ([self.editButton.currentTitle isEqualToString:@"Done"]) {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
                // Delete the row from the data source
            cell.textLabel.textColor = [UIColor blackColor];
            [self.tasks removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:YES];
            [self.tableView reloadData];
        
//        UIAlertController *alert = [[UIAlertControllerS alloc] initWithTitle:@"t" message:@"del?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
//        [alert show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:delete];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
       }
    }
      
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    if (buttonIndex != [alertView cancelButtonIndex]) {
        //my code to delete from the data source is here. it works fine.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (IBAction)onSwipeGesture:(UISwipeGestureRecognizer *)sender {
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint gestureLocation = [sender locationInView:self.tableView];
        NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:gestureLocation];
       UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
        if ([cell.textLabel.textColor isEqual:[UIColor redColor]] || [cell.textLabel.textColor isEqual:[UIColor blackColor]]) {
            cell.textLabel.textColor = [UIColor greenColor];
        }
        else if ([cell.textLabel.textColor isEqual:[UIColor greenColor]]) {
           cell.textLabel.textColor = [UIColor yellowColor];
        }
        else {
            cell.textLabel.textColor = [UIColor redColor];

        }
        [self.tableView reloadData];
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Process the row move. This means updating the data model to correct the item indices.

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:stringToMove atIndex:destinationIndexPath.row];
}

@end
