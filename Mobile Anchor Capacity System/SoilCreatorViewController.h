//
//  SoilCreatorViewController.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 6/24/14.
//  Copyright (c) 2014 VanR. All rights reserved.
#import "Soil.h"
#import <UIKit/UIKit.h>

@class SoilCreatorViewController;

@protocol SendSoilBack<NSObject>
-(void)SendSoilToCalcController:(Soil*) soil;
//@property (nonatomic,weak) id<SendSoilBack> delegate;
@end



@interface SoilCreatorViewController : UIViewController

@property (weak,nonatomic) id<SendSoilBack> delegate;
@property (weak, nonatomic) IBOutlet UITextField *soilNameField;
@property (weak, nonatomic) IBOutlet UISwitch *soilUnitsSwitch;
@property (nonatomic,strong) Soil  *thisSoil;
@property (weak, nonatomic) IBOutlet UIStepper *frictionAngleStepper;
@property (weak, nonatomic) IBOutlet UIStepper *unitWeightStepper;
@property (weak, nonatomic) IBOutlet UIStepper *cohesionStepper;
@property (weak, nonatomic) IBOutlet UILabel *unitWeightValue;
@property (weak, nonatomic) IBOutlet UILabel *frictionAngleValue;
@property (weak, nonatomic) IBOutlet UILabel *cohesionValue;
@property (weak, nonatomic) IBOutlet UILabel *unitWeightUnits;
@property (weak, nonatomic) IBOutlet UILabel *cohesionUnits;

- (IBAction)soilQuestions:(id)sender;
- (IBAction)SwitchDidChange:(id)sender;
- (IBAction)unitWtDidChange:(id)sender;
- (IBAction)frictionAngleDidChange:(id)sender;
- (IBAction)cohesionDidChange:(id)sender;
- (IBAction)textFieldDismiss:(id)sender;


- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;
-(void)popupmaker:(NSString *)title :(NSString *)message;

@end
