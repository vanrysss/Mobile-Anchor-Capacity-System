//
//  Calculation.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soil.h"
#import "Vehicle.h"

#define  KN_TO_KG  101.971
#define  KG_TO_KN  0.00980665

@interface Calculation : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic,copy)  NSString * engineerName;
@property (nonatomic,copy) NSString *jobSite;
@property (nonatomic,readonly,strong) NSDate *creationDate;
@property (nonatomic, copy) NSString *calcKey;

@property double latitude;
@property double longitude;
@property int beta;
@property double bladeDepth;
@property double delta;
@property int theta;
@property double anchorSetback;
@property double anchorHeight;
@property double Kp;

@property  Soil *calcSoil;
@property Vehicle *calcVehicle;

@property double momentValue;
@property double forceValue;

-(double)Alpha1;
-(double)Alpha2;
-(double)Pp;
-(double)AnchorCapacity;
-(double)MomentCapacity;
-(void)resetCalculation:(Calculation*)c;
-(id)init;
@end
