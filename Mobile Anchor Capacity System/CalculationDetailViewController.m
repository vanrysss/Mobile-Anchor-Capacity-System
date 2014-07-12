//
//  CalculationDetailViewController.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/25/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "CalculationDetailViewController.h"
#import "Calculation.h"
#import "Vehicle.h"
#import "Soil.h"
#import "SoilCreatorViewController.h"
#import "CalculationItemStore.h"

#define IMPERIAL_TO_METRIC 0.3048
#define KG_TO_LBS 2.2

@interface CalculationDetailViewController()
-(IBAction)LaunchSoilView:(id)sender;

@end

@implementation CalculationDetailViewController

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
 
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector (save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
    }
    
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    

    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    
    self.vehicleArray = [[NSMutableArray alloc]init];
    self.vehiclePicker.delegate = self;
    self.vehiclePicker.dataSource = self;
    self.vehiclePicker.showsSelectionIndicator = YES;
    [self.vehiclePicker setTag:1];
    [self populateStaticVehicles:self.vehicleArray];
    
    self.soilArray = [[NSMutableArray alloc]init];
    self.soilPicker.delegate=self;
    self.soilPicker.dataSource=self;
    self.soilPicker.showsSelectionIndicator= YES;
    [self.soilPicker setTag:2];
    [self populateStaticSoils:self.soilArray];
    
    
    [self.vehiclePicker reloadAllComponents];
    [self.soilPicker reloadAllComponents];
    
    [self.locationManager startUpdatingLocation];
    self.location = [[CLLocation alloc] init];
        
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the Item from the store
    [[CalculationItemStore sharedStore] removeItem:self.calculation];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    Calculation *calculation = self.calculation;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1323)];
    
    self.titleField.text = calculation.title;
    self.engineerNameField.text = calculation.engineerName;
    self.jobsiteField.text = calculation.jobSite;
    self.betaLabel.text = [NSString stringWithFormat: @"%d" ,calculation.beta];
    self.thetaLabel.text = [NSString stringWithFormat:@"%d" ,calculation.theta];
    
    
    //turn the Date into a date string
    static NSDateFormatter *dateFormatter =nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //use NSDate object to set dateField contents
    self.dateLabel.text = [dateFormatter stringFromDate:calculation.creationDate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //clear responder
    [self.view endEditing:YES];
    
    //save changes
    Calculation *calculation = self.calculation;
    calculation.title = self.titleField.text;
    calculation.engineerName = self.engineerNameField.text;
    calculation.jobSite = self.jobsiteField.text;
    
}

-(void)setItem:(Calculation *)calculation{
    _calculation = calculation;
    self.navigationItem.title = _calculation.title;
}


- (IBAction)calculateButton:(id)sender {
    Calculation *calculation = _calculation;
    calculation.title = self.titleField.text;
    calculation.engineerName = self.engineerNameField.text;
    calculation.jobSite = self.jobsiteField.text;
    calculation.beta = [self.betaLabel.text intValue];
    calculation.theta =[self.thetaLabel.text intValue];
    double doubleForce;
    double doubleMoment;
    
    if ([self.unitSwitch isOn]) {
        calculation.anchorSetback =[self.laLabel.text doubleValue] * IMPERIAL_TO_METRIC;
        calculation.anchorHeight =[self.haLabel.text doubleValue ]* IMPERIAL_TO_METRIC;
        calculation.bladeDepth = [self.dbLabel.text doubleValue]* IMPERIAL_TO_METRIC;
        doubleForce = [calculation AnchorCapacity] * KG_TO_LBS;
        doubleMoment = [calculation MomentCapacity] *KG_TO_LBS;
    }else{
        calculation.anchorSetback =[self.laLabel.text doubleValue];
        calculation.anchorHeight =[self.haLabel.text doubleValue];
        calculation.bladeDepth = [self.dbLabel.text doubleValue];
    doubleForce = [calculation AnchorCapacity];
    doubleMoment = [calculation MomentCapacity];
    }
    
    if (doubleForce < doubleMoment) {
        self.forceLabel.textColor = [UIColor redColor];
        self.momentLabel.textColor = [UIColor blackColor];
        
    }else{
        self.forceLabel.textColor = [UIColor blackColor];
        self.momentLabel.textColor = [UIColor redColor];
    }
    
    self.forceLabel.text = [NSString stringWithFormat: @"%.1f", doubleForce];
    self.momentLabel.text = [NSString stringWithFormat:@"%.1f", doubleMoment];
    
    
    
}

- (IBAction)betaValueChanged:(id)sender {
    self.betaLabel.text = [NSString stringWithFormat:@"%d" ,(int)self.betaSlider.value];
}

- (IBAction)thetaValueChanged:(id)sender {
    self.thetaLabel.text = [NSString stringWithFormat:@"%d" ,(int)self.thetaSlider.value];
}

- (IBAction)SwitchDidChange:(id)sender {
    
    if ([sender isOn]) {
        
        self.haUnitsLabel.text = @"Ft";
        self.laUnitsLabel.text = @"Ft";
        self.dbUnitsLabel.text = @"Ft";
        
        
    }else{
        self.haUnitsLabel.text = @"M";
        self.laUnitsLabel.text = @"M";
        self.dbUnitsLabel.text = @"M";
                
    }
}

- (IBAction)LaunchSoilView:(id)sender {
    
    SoilCreatorViewController *newSoilView = [[SoilCreatorViewController alloc]initWithNibName:@"SoilCreatorViewController" bundle:NULL];
    
    [self presentViewController:newSoilView animated:YES completion:nil];
}

- (IBAction)haDidChange:(id)sender {
    self.haLabel.text = [NSString stringWithFormat:@"%.1f" ,(double)self.heightAnchorSlider.value];

}

- (IBAction)ladidChange:(id)sender {
    self.laLabel.text = [NSString stringWithFormat:@"%.1f" ,(double)self.setbackSlider.value];

}

- (IBAction)dbDidChange:(id)sender {
    self.dbLabel.text = [NSString stringWithFormat:@"%.1f" ,(double)self.depthSlider.value];

}


// Question Mark Button Functions

-(IBAction)haQuestion:(id)sender{
    [self popupmaker :@"Anchor Height" :@"Ha is the vertical distance between the ground supporting the equipment and the anchor attachment point.The lower Ha is, the more stable the equipment anchor will be against overturning." ];
    
}

-(IBAction)laQuestion:(id)sender{
    
    [self popupmaker:@"Anchor Setback" :@"La is the lateral distance between the point of rotation (i.e. the bottom of an embedded blade, the toe of the vehicle, etc.)and the point at which an anchor is attached."];
    
}

-(IBAction)dbQuestion:(id)sender{
    [self popupmaker:@"Blade Depth" :@"Db is the embedment depth of the equipment. This value is representative of the depth below the soil depending on the scenario."];
}

- (IBAction)thetaQuestion:(id)sender {
    [self popupmaker:@"Theta" :@"Theta is the angle of the guyline from the horizontal plane."];
}



- (IBAction)betaQuestion:(id)sender {
    [self popupmaker:@"Beta" :@"Beta is the angle of slope from the horizontal plane."];
   
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

-(void)populateStaticVehicles:(NSMutableArray *)vehicles{
    Vehicle *none = [[Vehicle alloc]init];
    none.vehicleType = @"none";
    
    Vehicle *catD6 = [[Vehicle alloc]init];
    catD6.vehicleClass = @"Bulldozer";
    catD6.vehicleType = @"CAT D6";
    catD6.vehicleWeight = 24494.0;
    catD6.bladeWidth = 3.35;
    catD6.centerOfGravity = 2.65;
    catD6.centerofGravityHeight = 1.07;
    catD6.trackLength = 2.87;
    catD6.trackWidth = 0.55;
    
    Vehicle *catD7 = [[Vehicle alloc]init];
    catD7.vehicleClass = @"Bulldozer";
    catD7.vehicleType = @"CAT D7";
    catD7.vehicleWeight = 18143.7;
    catD7.bladeWidth = 3.9;
    catD7.centerOfGravity = 3.14;
    catD7.centerofGravityHeight = 1.16;
    catD7.trackLength = 2.87;
    catD7.trackWidth = 0.55;
    
    Vehicle *catD8 = [[Vehicle alloc]init];
    catD8.vehicleClass = @"Bulldozer";
    catD8.vehicleType = @"CAT D8";
    catD8.vehicleWeight = 36287.39;
    catD8.bladeWidth = 3.93;
    catD8.centerOfGravity = 3.45;
    catD8.centerofGravityHeight = 1.16;
    catD8.trackLength = 3.2;
    catD8.trackWidth = 0.55;
    
    
    Vehicle *catD9 = [[Vehicle alloc]init];
    catD9.vehicleClass = @"Bulldozer";
    catD9.vehicleType = @"CAT 320- Drawbar Attachment ";
    catD9.vehicleWeight = 21318.8;
    catD9.bladeWidth = 0.91;
    catD9.centerOfGravity = 6.7;
    catD9.centerofGravityHeight = 1.25;
    catD9.trackLength = 3.26;
    catD9.trackWidth = 0.56;
    
    Vehicle *catD10 = [[Vehicle alloc]init];
    catD10.vehicleClass = @"Bulldozer";
    catD10.vehicleType = @"CAT 320- Elbow Attachment ";
    catD10.vehicleWeight = 21318.8;
    catD10.bladeWidth = 0.91;
    catD10.centerOfGravity = 6.7;
    catD10.centerofGravityHeight = 1.25;
    catD10.trackLength = 3.26;
    catD10.trackWidth = 0.56;
    
    Vehicle *catD11 = [[Vehicle alloc]init];
    catD11.vehicleClass = @"Bulldozer";
    catD11.vehicleType = @"CAT 330- Drawbar Attachment ";
    catD11.vehicleWeight = 35108;
    catD11.bladeWidth = 0.91;
    catD11.centerOfGravity = 6.7;
    catD11.centerofGravityHeight = 1.25;
    catD11.trackLength = 4.05;
    catD11.trackWidth = 0.86;
    
    Vehicle *catD12 = [[Vehicle alloc]init];
    catD12.vehicleClass = @"Bulldozer";
    catD12.vehicleType = @"CAT 320- Elbow Attachment ";
    catD12.vehicleWeight = 35108;
    catD12.bladeWidth = 0.91;
    catD12.centerOfGravity = 6.7;
    catD12.centerofGravityHeight = 1.25;
    catD12.trackLength = 4.05;
    catD12.trackWidth = 0.86;
    
    [self.vehicleArray addObject:none];
    [self.vehicleArray addObject:catD6];
    [self.vehicleArray addObject:catD7];
    [self.vehicleArray addObject:catD8];
    [self.vehicleArray addObject:catD9];
    [self.vehicleArray addObject:catD10];
    [self.vehicleArray addObject:catD11];
    [self.vehicleArray addObject:catD12];
    
}

-(void)populateStaticSoils:(NSMutableArray*)soilArray{
    
    Soil *none = [[Soil alloc]init];
    none.soilType = @"none";
    
    Soil *uncLoose = [[Soil alloc]init];
    uncLoose.soilType = @"Uncompacted Loose Silt/Soil/Gravel";
    uncLoose.cohesion = 0;
    uncLoose.frictionAngle = 25;
    uncLoose.unitWeight =1522;
    
    Soil *lightcmpct = [[Soil alloc]init];
    lightcmpct.soilType = @"Lightly Compacted Silt/Sand/Gravel";
    lightcmpct.cohesion = 0;
    lightcmpct.frictionAngle = 30;
    lightcmpct.unitWeight = 1762;
    
    Soil *denseCmpct = [[Soil alloc]init];
    denseCmpct.soilType = @"Dense Compacted Silt/Sand/Gravel";
    denseCmpct.cohesion = 0;
    denseCmpct.frictionAngle = 35;
    denseCmpct.unitWeight = 2082;
    
    Soil *softClay = [[Soil alloc]init];
    softClay.soilType = @"Soft Clay";
    softClay.cohesion = 23.9;
    softClay.frictionAngle = 0;
    softClay.unitWeight = 1522;
    
    Soil *firmClay = [[Soil alloc]init];
    firmClay.soilType = @"Firm Clay";
    firmClay.cohesion = 47.88;
    firmClay.frictionAngle =0;
    firmClay.unitWeight = 1522;
    
    Soil *stiffClay = [[Soil alloc]init];
    stiffClay.soilType = @"Stiff Clay";
    stiffClay.cohesion = 95.76;
    stiffClay.frictionAngle = 0;
    stiffClay.unitWeight = 1522;
    
    Soil *hardClay = [[Soil alloc]init];
    hardClay.soilType = @"Hard Clay";
    hardClay.cohesion = 191.52;
    hardClay.frictionAngle = 0;
    hardClay.unitWeight = 1522;
    
    Soil *veryStiffClay = [[Soil alloc]init];
    veryStiffClay.soilType = @"Very Stiff Clay";
    veryStiffClay.cohesion = 143.64;
    veryStiffClay.frictionAngle = 0;
    stiffClay.unitWeight = 1522;
    
    
    
    [self.soilArray addObject:none];
    [self.soilArray addObject:uncLoose];
    [self.soilArray addObject:lightcmpct];
    [self.soilArray addObject:denseCmpct];
    [self.soilArray addObject:softClay];
    [self.soilArray addObject:firmClay];
    [self.soilArray addObject:stiffClay];
    [self.soilArray addObject:hardClay];
    [self.soilArray addObject:veryStiffClay];
}


#pragma pickerview handlers

// How many columns of components
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// How many rows are there in the UIPicker
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return self.vehicleArray.count;
    }else{
        return self.soilArray.count;
    }
}

// Row title corresponds to Vehicle's Type
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        NSLog(@"adding vehicle to spinner");
        return ((Vehicle *) [self.vehicleArray objectAtIndex:row]).vehicleType;
    }else{
        NSLog(@"adding soil to spinner");
        return ((Soil*) [self.soilArray objectAtIndex:row]).soilType;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1) {

        _calculation.calcVehicle = [self.vehicleArray objectAtIndex:row];
        NSLog(@"calculation assigned vehicle");
    }else{
        _calculation.calcSoil = [self.soilArray objectAtIndex:row];
        NSLog(@"calculation assigned soil");
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    //NSLog(@"%@", self.location.description);
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
}




@end
