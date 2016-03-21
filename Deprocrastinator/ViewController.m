//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Dylan Bruschi on 3/21/16.
//  Copyright © 2016 Dylan Bruschi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOutlet;

@property NSMutableArray *tasks;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tasks.count;
}

- (IBAction)onAddButtonPressed:(id)sender {
    
    NSString *task = self.textFieldOutlet.text;
    [self.tasks addObject:task];
}

@end
