//
//  Calculation.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "Calculation.h"
#import <Foundation/Foundation.h>

@implementation Calculation

-(double)Alpha1{
    self.delta = (self.calcSoil.frictionAngle) / 3;
    
    double top = cos(self.beta) - tan(self.delta) * sin(self.beta);
    double bot = sin(self.beta) + tan(self.delta) * cos(self.beta);
    
    return sin(self.beta) + cos(self.beta) *(top/bot);
}

-(double)Alpha2{
    self.delta = (self.calcSoil.frictionAngle) / 3;
    double top = cos(self.beta) - tan(self.delta) * sin(self.beta);
    double bot = sin(self.beta) + tan(self.delta) * cos(self.beta);
    
    return sin(self.beta) + sin(self.theta) *(top/bot);

}

-(double)Pp{
    
    double answer = 0.5 * (self.calcSoil.unitWeight * KG_TO_KN) * pow(self.bladeDepth,2) * self.calcVehicle.bladeWidth * self.Kp + 2 *self.calcSoil.cohesion * self.calcVehicle.bladeWidth * sqrt(self.Kp);
    
    return answer;
}

-(double)AnchorCapacity{
    self.delta = self.calcSoil.frictionAngle / 3;
    
    //in order to prevent division by zero
    if (self.beta ==0 && self.theta == 0) {
        self.beta = 1;
        self.theta = 1;
    }
    
    self.Kp = pow(tan(45* self.calcSoil.frictionAngle)/2, 2);
    if (self.theta - self.beta >= self.delta) {
        self.Kp=0;
    }else if (self.theta - self.beta >0){
        self.Kp = 0.5 * self.Kp;
    }
    
    double gamma = self.calcSoil.unitWeight * KG_TO_KN;
    double nb = self.Kp * [self Alpha1];
    double nc = 2 * sqrt(self.Kp) * [self Alpha1];
    double nct = [self Alpha1] / [self Alpha2];
    double nw = 1/[self Alpha2];
    double wv = self.calcVehicle.vehicleWeight * KG_TO_KN;
    
    double prelim = 0.5 * gamma * pow(self.bladeDepth, 2) * self.calcVehicle.bladeWidth * nb + (self.calcSoil.cohesion * self.calcVehicle.bladeWidth * nc) + (self.calcSoil.cohesion * self.calcVehicle.TrackArea * nct) + (wv * nw);
    
    self.forceValue = prelim * KN_TO_KG;
    return self.forceValue;
    
}

-(double)MomentCapacity{
    double wv = self.calcVehicle.vehicleWeight * KG_TO_KN;
    double top = (wv *(self.calcVehicle.centerOfGravity * cos(self.beta) - (self.bladeDepth + self.calcVehicle.centerofGravityHeight) * sin(self.beta)) + [self Pp] * (self.bladeDepth/3));
    
    double bot = cos(self.theta - self.beta) * (self.bladeDepth + self.anchorHeight) + sin(self.theta - self.beta) * self.anchorSetback;
    
    double prelim = (top/bot);
    self.momentValue= prelim * KN_TO_KG;
    return self.momentValue;
}

-(void)resetCalculation:(Calculation *)c{
    c.beta = 0;
    c.bladeDepth = 0;
    c.anchorSetback = 0;
    c.anchorHeight =0;
    c.theta =0;
    
}
-(instancetype)initWithItemName:(NSString *)value{
    self = [super init];
    if (self) {
        _title = value;
        
    }
    return self;
}
-(instancetype)init{
    return [self initWithItemName:@"Item"];
}

@end
