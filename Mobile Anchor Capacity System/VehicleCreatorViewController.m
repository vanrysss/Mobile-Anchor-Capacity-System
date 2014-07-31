//
//  VehicleCreatorViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 7/28/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "VehicleCreatorViewController.h"

@interface VehicleCreatorViewController ()

@end

@implementation VehicleCreatorViewController

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

- (IBAction)unitsDidChange:(id)sender {
    
    if ([sender isOn]) {
        self.vehicleWeightLabel = @"KG";
        self.hgUnitLabel =@"M";
        self.cgUnitLabel =@"M";
        self.trackLengthUnitLabel = @"M";
        self.trackWidthUnitLabel = @"M";
        self.bladeWidthUnitLabel =@"M";
    }else{
        self.vehicleWeightLabel = @"LBS";
        self.hgUnitLabel =@"Ft";
        self.cgUnitLabel =@"Ft";
        self.trackLengthUnitLabel = @"Ft";
        self.trackWidthUnitLabel = @"Ft";
        self.bladeWidthUnitLabel =@"Ft";
    }
}

- (IBAction)hgQuestion:(id)sender {
    
    [self popupmaker:@"Center of Gravity Height" :@"Vehicle's center of gravity height above the surface. The lower, the more stable the quipment will be."];
}

- (IBAction)cgQuestion:(id)sender {
    
    [self popupmaker:@"Center of Gravity Offset" :@"Lateral distance between the center of gravity and the point of rotation."];
}

- (IBAction)wvQuestion:(id)sender {
    [self popupmaker:@"Vehicle Weight" :@""];
}

- (IBAction)tlQuestion:(id)sender {
    [self popupmaker:@"Track Length" :@""];
}

- (IBAction)twQuestion:(id)sender {
    [self popupmaker:@"Track Width" :@""];
}

- (IBAction)wbQuestion:(id)sender {
    [self popupmaker:@"Blade Widht" :@""];
}

- (IBAction)saveVehicle:(id)sender {
    _vehicle.vehicleClass = _vehicleClassField.text;
    _vehicle.vehicleType = _vehicleTypeField.text;
    _vehicle.vehicleWeight = [_vehicleWeightLabel.text doubleValue];
    _vehicle.trackLength = [_trackLengthLabel.text doubleValue];
    _vehicle.trackWidth = [_trackWidthLabel.text doubleValue];
    _vehicle.bladeWidth = [_bladeWidthLabel.text doubleValue];
    _vehicle.centerofGravityHeight = [_vehicleHeightLabel.text doubleValue];
    _vehicle.centerOfGravity = [_vehicleCenterOfGravityOffsetLabel.text doubleValue];
    
    [self.delegate addItemViewController:self didFinishItem:_vehicle];

}

- (IBAction)hgDidChange:(id)sender {
    self.vehicleHeightLabel.text =[NSString stringWithFormat:@"%.1f" ,(double)self.hgSlider.value];
}

- (IBAction)cgDidChange:(id)sender {
    self.vehicleCenterOfGravityOffsetLabel.text = [NSString stringWithFormat:@"%.1f", (double)self.cgSlider.value];
    
}

- (IBAction)tlDidChange:(id)sender {
    self.trackLengthLabel.text =[NSString stringWithFormat:@"%.1f", (double)self.tlSlider.value];
}

- (IBAction)twDidChange:(id)sender {
    self.trackWidthLabel.text = [NSString stringWithFormat:@"%.1f", (double)self.twSlider.value];
}

- (IBAction)wbDidChange:(id)sender {
    self.bladeWidthLabel.text = [NSString stringWithFormat:@"%.1f", (double)self.twSlider.value];
}

- (IBAction)wvDidSet:(id)sender {
    self.vehicleWeightLabel.text = [NSString stringWithFormat:@"%@", self.vehicleWeightField.text];
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
