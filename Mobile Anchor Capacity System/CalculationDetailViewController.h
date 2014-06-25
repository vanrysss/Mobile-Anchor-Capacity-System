//
//  CalculationDetailViewController.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/25/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SoilCreatorViewController.h"

@class CalculationDetailViewController;
@class Calculation;
@class Vehicle;
@class Soil;


@protocol CalculationDetailViewControllerDelegate <NSObject>

-(void)CalculationDetailViewDidCancel:(CalculationDetailViewController *)controller;
-(void)CalculationDetailView:(CalculationDetailViewController *)controller didFinishAddingItem:(Calculation *)item;

@end

@interface CalculationDetailViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate>{
    
    UIPickerView *vehiclePicker;
    NSMutableArray *vehicleArray;
    UIPickerView *soilPicker;
    NSMutableArray *soilArray;
    
}

@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic,strong) Calculation *calculation;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *engineerNameField;
@property (weak, nonatomic) IBOutlet UITextField *jobsiteField;
@property (weak, nonatomic) IBOutlet UISwitch *unitsSelector;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UIPickerView *vehiclePicker;
@property (retain, nonatomic) IBOutlet UIPickerView *soilPicker;
@property (weak, nonatomic) IBOutlet UISlider *betaSlider;
@property (weak, nonatomic) IBOutlet UISlider *thetaSlider;
@property (weak, nonatomic) IBOutlet UISlider *heightAnchorSlider;
@property (weak, nonatomic) IBOutlet UISlider *setbackSlider;
@property (weak, nonatomic) IBOutlet UISlider *depthSlider;
@property (weak, nonatomic) IBOutlet UILabel *betaLabel;
@property (weak, nonatomic) IBOutlet UILabel *thetaLabel;
@property (weak, nonatomic) IBOutlet UILabel *haLabel;
@property (weak, nonatomic) IBOutlet UILabel *laLabel;
@property (weak, nonatomic) IBOutlet UILabel *dbLabel;
- (IBAction)haDidChange:(id)sender;
- (IBAction)ladidChange:(id)sender;
- (IBAction)dbDidChange:(id)sender;
- (IBAction)calculateButton:(id)sender;
- (IBAction)betaValueChanged:(id)sender;
- (IBAction)thetaValueChanged:(id)sender;

-(IBAction)haQuestion:(id)sender;
-(IBAction)laQuestion:(id)sender;
-(IBAction)dbQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *forceLabel;
@property (weak, nonatomic) IBOutlet UILabel *momentLabel;
@property (strong, nonatomic) NSMutableArray *vehicleArray;
@property (strong, nonatomic) NSMutableArray *soilArray;


@property (nonatomic,weak) id <CalculationDetailViewControllerDelegate> delegate;
-(instancetype)initForNewItem:(BOOL)isNew;
-(void)populateStaticVehicles:(NSMutableArray*)vehicles;
-(void)populateStaticSoils:(NSMutableArray*)soils;
-(void)popupmaker:(NSString *)title :(NSString *)message;
@end
