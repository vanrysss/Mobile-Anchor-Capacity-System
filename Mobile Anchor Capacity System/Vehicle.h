//
//  Vehicle.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property NSString *vehicleClass;
@property NSString *vehicleType;
@property double centerOfGravity; // distance of vehicle center of gravity from anchor
@property double centerofGravityHeight; // height of center of gravity from soil
@property double vehicleWeight; // weight of vehicle
@property double trackLength; //track length
@property double trackWidth; //track width
@property double bladeWidth; //blade width

-(double) TrackArea;
@end
