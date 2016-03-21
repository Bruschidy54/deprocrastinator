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
            
       }
    }
      
}
- (IBAction)onSwipeGesture:(UISwipeGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint gestureLocation = [sender locationInView:self.tableView];
        NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:gestureLocation];
        //found IndexPath for swiped cell. Now we can do anything what we need.
        //In my case it's cell reloading with new image in UIImageView.
       UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
         cell.textLabel.textColor = [UIColor redColor];
        [self.tableView reloadData];
    
    
}
}



@end
