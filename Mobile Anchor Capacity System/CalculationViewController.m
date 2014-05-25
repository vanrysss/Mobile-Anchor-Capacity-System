//
//  CalculationViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//
#import "Calculation.h"
#import "CalculationViewController.h"
#import "CalculationItemStore.h"

@interface CalculationViewController ()

@property (weak,nonatomic) IBOutlet UITextField *CalcIdentifier;
@property (weak,nonatomic) IBOutlet UITextField *EngineerName;
@property (weak,nonatomic) IBOutlet UITextField *JobSiteID;
@property (weak,nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation CalculationViewController

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
        // Make sure this is NOT in the if (isNew ) { } block of code
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(updateFonts)
                              name:UIContentSizeCategoryDidChangeNotification
                            object:nil];
    }
    
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    Calculation *calculation = self.calculation;
    
    self.CalcIdentifier.text = calculation.title;
    self.EngineerName.text = calculation.engineerName;
    self.JobSiteID.text = calculation.jobSite;
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:calculation.creationDate];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to calculation
   Calculation *calc= self.calculation;
    calc.title = self.CalcIdentifier.text;
    calc.engineerName = self.EngineerName.text;
    calc.jobSite = self.JobSiteID.text;

}

- (void)setItem:(Calculation *)calculation
{
    _calculation = calculation;
    self.navigationItem.title = _calculation.title;
}



@end
