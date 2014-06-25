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
@property (weak, nonatomic) IBOutlet UISlider *soilUnitWeightSlider;
@property (weak, nonatomic) IBOutlet UISlider *soilFrictionAngleSlider;
@property (weak, nonatomic) IBOutlet UISlider *soilCohesionSlider;
- (IBAction)unitWeightQuestion:(id)sender;
- (IBAction)frictionAngleQuestion:(id)sender;
- (IBAction)cohesionQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *unitweightSlider;
@property (weak, nonatomic) IBOutlet UISlider *frictionAngleSlider;
@property (weak, nonatomic) IBOutlet UISlider *cohesionSlider;

- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;

@property (nonatomic,weak) id <SoilCreatorDelegate> delegate;
-(void)popupmaker:(NSString *)title :(NSString *)message;

@end
