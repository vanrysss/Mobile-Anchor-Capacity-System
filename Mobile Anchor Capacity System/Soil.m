//
//  Soil.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "Soil.h"

@implementation Soil

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.soilType forKey:@"soilType"];
    [aCoder encodeDouble:self.unitWeight forKey:@"unitWeight"];
    [aCoder encodeDouble:self.cohesion forKey:@"cohesion"];
    [aCoder encodeInt:self.frictionAngle forKey:@"frictionAngle"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _soilType = [aDecoder decodeObjectForKey:@"soilType"];
        _unitWeight = [aDecoder decodeDoubleForKey:@"unitWeight"];
        _cohesion = [aDecoder decodeDoubleForKey:@"cohesion"];
        _frictionAngle = [aDecoder decodeIntForKey:@"frictionAngle"];
    }
    return self;
}

@end
