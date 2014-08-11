//
//  Vehicle.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

-(double)TrackArea{
    return self.trackLength * self.trackWidth;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.vehicleClass forKey:@"vehicleClass"];
    [aCoder encodeObject:self.vehicleType forKey:@"vehicleType"];
    [aCoder encodeDouble:self.centerOfGravity forKey:@"centerofGravity"];
    [aCoder encodeDouble:self.centerofGravityHeight forKey:@"centerofGravityHeight"];
    [aCoder encodeInt:self.vehicleWeight forKey:@"weight"];
    [aCoder encodeDouble:self.trackLength forKey:@"trackLength"];
    [aCoder encodeDouble:self.trackWidth forKey:@"trackWidth"];
    [aCoder encodeDouble:self.bladeWidth forKey:@"bladeWidth"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
    
    _vehicleClass = [aDecoder decodeObjectForKey:@"vehicleClass" ];
    _vehicleType = [aDecoder decodeObjectForKey:@"vehicleType"];
    _vehicleWeight = [aDecoder decodeDoubleForKey:@"weight"];
    _centerOfGravity = [aDecoder decodeDoubleForKey:@"centerofGravity"];
    _centerofGravityHeight = [aDecoder decodeDoubleForKey:@"centerofGravityHeight"];
    _vehicleWeight = [aDecoder decodeIntForKey:@"weight"];
    _trackLength = [aDecoder decodeDoubleForKey:@"trackLength"];
    _trackWidth = [aDecoder decodeDoubleForKey:@"trackWidth"];
    _bladeWidth = [aDecoder decodeDoubleForKey:@"bladeWidth"];
    }
    return self;
}
@end
