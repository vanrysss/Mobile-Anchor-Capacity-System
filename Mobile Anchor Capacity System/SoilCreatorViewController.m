//
//  SoilCreatorViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 6/24/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "SoilCreatorViewController.h"
#import "CalculationDetailViewController.h"
#import "Soil.h"



@interface SoilCreatorViewController ()

@end

@implementation SoilCreatorViewController

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

- (IBAction)unitWeightQuestion:(id)sender {
    [self popupmaker :@"Unit Weight": @"dummy?"];
}


- (IBAction)frictionAngleQuestion:(id)sender {
    [self popupmaker :@"Friction Angle" : @"Phi is the angle of internal friction for soil, which governs soil strength and resistance. This value should be attained from competentfield testing and the judgment of a licensed engineer."];
}

- (IBAction)cohesionQuestion:(id)sender {
    
    [self popupmaker :@"Soil Cohesion": @"Cohesion defines the non-stress dependent shear strength of soil and should be used with caution. Typically,cohesion occurs in stiff, over-consolidated clays or cemented native soils. Cohesion should be neglected if the designer is unsure of its presence."];
}

- (IBAction)frictionAngleSlider:(id)sender {
    
}
- (IBAction)cohesionSlider:(id)sender {
}


- (IBAction)cancelButton:(id)sender {
}

- (IBAction)saveButton:(id)sender {
}

-(void)popupmaker:(NSString *)title :(NSString *)message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:title
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil
                          ];
    [alert show];
}
@end
