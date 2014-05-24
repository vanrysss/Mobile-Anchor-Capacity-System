//
//  ItemsViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/23/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "ItemsViewController.h"
#import "Calculation.h"
#import "CalculationItemStore.h"

@interface ItemsViewController()
@property  (nonatomic,strong) IBOutlet UIView *headerView;

@end

@implementation ItemsViewController

-(instancetype) init{
    //call super class
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i=0; i <5; i++) {
            [[CalculationItemStore sharedStore]init];
        }
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[CalculationItemStore sharedStore]allCalculations]count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //create instance with default appearance
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //set text on the cell with a description of the Calculation
    NSArray *items =[[CalculationItemStore sharedStore]allCalculations];
    Calculation *item = items[indexPath.row];
    
    cell.textLabel.text = item.title;
    
    return cell;
}

-(IBAction)addNewItem:(id)sender{
    
}

-(IBAction)toggleEditingMode:(id)sender{
    
}

@end
