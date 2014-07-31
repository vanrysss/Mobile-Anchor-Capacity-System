//
//  VehicleCreatorViewController.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 7/28/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"
@class VehicleCreatorViewController;
@protocol VehicleCreatorViewDelegate <NSObject>
-(void)addItemViewController:(VehicleCreatorViewController *)controller didFinishItem:(Vehicle *)item;

@property (nonatomic, weak) id <VehicleCreatorViewDelegate> delegate;
@end

@interface VehicleCreatorViewController : UIViewController

@property (weak,nonatomic) id <VehicleCreatorViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *vehicleWeightField;
@property (weak, nonatomic) IBOutlet UIStepper *hgSlider;
@property (weak, nonatomic) IBOutlet UIStepper *cgSlider;
@property (weak, nonatomic) IBOutlet UIStepper *tlSlider;
@property (weak, nonatomic) IBOutlet UIStepper *twSlider;

@property (weak, nonatomic) IBOutlet UIStepper *wbSlider;
@property (weak, nonatomic) IBOutlet UITextField *vehicleTypeField;
@property (weak, nonatomic) IBOutlet UITextField *vehicleClassField;
@property(weak,nonatomic) Vehicle* vehicle;
@property (weak, nonatomic) IBOutlet UILabel *vehicleHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleCenterOfGravityOffsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bladeWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *hgUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *cgUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleWeightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackLengthUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackWidthUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *bladeWidthUnitLabel;
@property (weak, nonatomic) IBOutlet UISwitch *vehicleUnitSwitch;
- (IBAction)unitsDidChange:(id)sender;
- (IBAction)hgQuestion:(id)sender;
- (IBAction)cgQuestion:(id)sender;
- (IBAction)wvQuestion:(id)sender;
- (IBAction)tlQuestion:(id)sender;
- (IBAction)twQuestion:(id)sender;
- (IBAction)wbQuestion:(id)sender;
- (IBAction)saveVehicle:(id)sender;

- (IBAction)hgDidChange:(id)sender;
- (IBAction)cgDidChange:(id)sender;
- (IBAction)tlDidChange:(id)sender;
- (IBAction)twDidChange:(id)sender;
- (IBAction)wbDidChange:(id)sender;
- (IBAction)wvDidSet:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *cancelCreationofVehicle;



@end
