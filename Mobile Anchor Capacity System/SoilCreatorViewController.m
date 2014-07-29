//
//  SoilCreatorViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 6/24/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "SoilCreatorViewController.h"

#define IMPERIAL_TO_METRIC 0.3048
#define KG_TO_LBS 2.2

@interface SoilCreatorViewController ()

@end

@implementation SoilCreatorViewController

Soil *soil;


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



- (IBAction)soilQuestions:(id)sender {
    
        [self popupmaker :@"Friction Angle" : @"Phi is the angle of internal friction for soil, which governs soil strength and resistance. This value should be attained from competent field testing and the judgment of a licensed engineer."];
    
        [self popupmaker :@"Soil Cohesion": @"Cohesion defines the non-stress dependent shear strength of soil and should be used with caution. Typically,cohesion occurs in stiff, over-consolidated clays or cemented native soils. Cohesion should be neglected if the designer is unsure of its presence."];
}

- (IBAction)SwitchDidChange:(id)sender {
           if ([sender isOn]) {
            
            self.cohesionUnits.text = @"Ft";
            self.unitWeightUnits.text= @"M";
            
            
        }else{
            self.cohesionUnits.text = @"M";
            self.unitWeightUnits.text = @"M";
            
        }
    }


- (IBAction)UnitSwitch:(id)sender {
    
    if ([sender isOn]) {
        self.unitWeightUnits.text = @"LBS/cubic Ft.";
        self.cohesionUnits.text = @"imp";
    }else{
        self.unitWeightUnits.text = @"KG/m3";
        self.cohesionUnits.text = @"met";
    }
}

- (IBAction)cancelButton:(id)sender {
    
}

- (IBAction)saveButton:(id)sender {
    
    soil.soilType = self.soilNameField.text;
    soil.frictionAngle = [self.frictionAngleValue.text integerValue];
    
    if ([self.soilUnitsSwitch isOn] ) {
        soil.cohesion = [self.cohesionValue.text doubleValue];
        soil.unitWeight = [self.unitWeightValue.text doubleValue];
    }else{
        soil.cohesion = [self.cohesionValue.text doubleValue];
        soil.unitWeight = [self.unitWeightValue.text doubleValue];
    }
    
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
