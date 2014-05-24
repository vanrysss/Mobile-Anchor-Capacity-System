//
//  CalculationViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "CalculationViewController.h"

@interface CalculationViewController ()

@property (nonatomic,weak) IBOutlet UITextField *CalcIdentifier;
@property (nonatomic,weak) IBOutlet UITextField *EngineerName;
@property (nonatomic,weak) IBOutlet UITextField *JobSiteID;

@end

@implementation CalculationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
