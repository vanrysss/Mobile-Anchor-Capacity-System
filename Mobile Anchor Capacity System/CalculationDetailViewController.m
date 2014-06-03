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

@interface CalculationDetailViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation CalculationDetailViewController

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
- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    myScrollView.contentSize = CGSizeMake(800,2000);
    myScrollView.scrollEnabled = YES;
    self.vehicleArray = [[NSMutableArray alloc]init];
    [self populateStaticVehicles:self.vehicleArray];
    
    vehiclePicker.delegate = self;
    vehiclePicker.dataSource = self;
    vehiclePicker.showsSelectionIndicator = YES;
    [vehiclePicker setTag:1];
    [vehiclePicker reloadAllComponents];
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    
    self.colorArray = @[@"Blue",@"Green",@"Orange",@"Purple",@"Red",@"Yellow"];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

 
    Calculation *calculation = self.calculation;
    
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
    Calculation *calculation = self.calculation;
    calculation.title = self.titleField.text;
    calculation.engineerName = self.engineerNameField.text;
    calculation.jobSite = self.jobsiteField.text;
    calculation.beta = self.betaSlider.value;
    calculation.theta =self.thetaSlider.value;
    calculation.anchorSetback =self.setbackSlider.value;
    calculation.anchorHeight =self.heightAnchorSlider.value;
    calculation.bladeDepth = self.depthSlider.value;
    
    //add vehicle to calculation
    double doubleForce = [calculation forceValue];
    double doublemoment = [calculation MomentCapacity];
                          
    self.forceLabel.text = [NSString stringWithFormat: @"%f", doubleForce];
    self.momentLabel.text = [NSString stringWithFormat:@"%f", doublemoment];
    
    
    
}

- (IBAction)betaValueChanged:(id)sender {
    self.betaLabel.text = [NSString stringWithFormat:@"%d" ,(int)self.betaSlider.value];
}

- (IBAction)thetaValueChanged:(id)sender {
    self.thetaLabel.text = [NSString stringWithFormat:@"%d" ,(int)self.thetaSlider.value];
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

-(void)populateStaticVehicles:(NSMutableArray *)vehicleArray{
    Vehicle *catD6 = [[Vehicle alloc]init];
    catD6.vehicleClass = @"Bulldozer";
    catD6.vehicleType = @"CAT D6";
    
    Vehicle *catD7 = [[Vehicle alloc]init];
    catD7.vehicleClass = @"Bulldozer";
    catD7.vehicleType = @"CAT D7";
    
    Vehicle *catD8 = [[Vehicle alloc]init];
    catD8.vehicleClass = @"Bulldozer";
    catD8.vehicleType = @"CAT D8";
    
    Vehicle *catD9 = [[Vehicle alloc]init];
    catD9.vehicleClass = @"Bulldozer";
    catD9.vehicleType = @"CAT D9";
    
    [self.vehicleArray addObject:catD6];
    [self.vehicleArray addObject:catD7];
    [self.vehicleArray addObject:catD8];
    [self.vehicleArray addObject:catD9];
    
}
#pragma pickerview

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return vehicleArray.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Vehicle *v =[vehicleArray objectAtIndex:row];
    return v.vehicleType;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    //NSLog(@"%@", self.location.description);
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
}

@end
