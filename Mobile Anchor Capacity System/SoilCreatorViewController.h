//
//  SoilCreatorViewController.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 6/24/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculationDetailViewController.h"

@class SoilCreatorViewController;
@protocol SoilCreatorDelegate <NSObject>

-(void)addItemViewController:(SoilCreatorViewController *)controller didFinishItem:(NSString *)item;

@end

@interface SoilCreatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *soilNameField;
@property (weak, nonatomic) IBOutlet UISwitch *soilUnitsSwitch;

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


- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;

@property (nonatomic,weak) id <SoilCreatorDelegate> delegate;
-(void)popupmaker:(NSString *)title :(NSString *)message;

@end
