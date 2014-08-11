//
//  Soil.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Soil : NSObject<NSCoding>

@property NSString *soilType;
@property double unitWeight;
@property int frictionAngle;
@property double cohesion;

@end
