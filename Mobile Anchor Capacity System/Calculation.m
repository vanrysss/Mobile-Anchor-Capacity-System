//
//  Calculation.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "Calculation.h"
#import <Foundation/Foundation.h>

@interface Calculation()
@property (nonatomic, strong) NSDate *creationDate;

@end

@implementation Calculation

-(double)Alpha1{
    self.delta = (_calcSoil.frictionAngle) / 3;
    
    double top = cos(_beta) - tan(_delta) * sin(_beta);
    double bot = sin(_beta) + tan(_delta) * cos(_beta);
    
    return sin(_beta) + cos(_beta) *(top/bot);
}

-(double)Alpha2{
    self.delta = (_calcSoil.frictionAngle) / 3;
    double top = cos(_beta) - tan(_delta) * sin(_beta);
    double bot = sin(_beta) + tan(_delta) * cos(_beta);
    
    return sin(_beta) + sin(_theta) *(top/bot);

}

-(double)Pp{
    
    double answer = 0.5 * (_calcSoil.unitWeight * KG_TO_KN) * pow(_bladeDepth,2) * _calcVehicle.bladeWidth * _Kp + 2 *_calcSoil.cohesion * _calcVehicle.bladeWidth * sqrt(_Kp);
    
    return answer;
}

-(double)AnchorCapacity{
    _delta = _calcSoil.frictionAngle / 3;
    
    //in order to prevent division by zero
    if (_beta ==0 && _theta == 0) {
        _beta = 1;
        _theta = 1;
    }
    
    _Kp = pow(tan(45* _calcSoil.frictionAngle)/2, 2);
    if (_theta - _beta >= _delta) {
        _Kp=0;
    }else if (_theta - _beta >0){
        _Kp = 0.5 * _Kp;
    }
    
    double gamma = _calcSoil.unitWeight * KG_TO_KN;
    double nb = _Kp * [self Alpha1];
    double nc = 2 * sqrt(_Kp) * [self Alpha1];
    double nct = [self Alpha1] / [self Alpha2];
    double nw = 1/[self Alpha2];
    double wv = _calcVehicle.vehicleWeight * KG_TO_KN;
    
    double prelim = 0.5 * gamma * pow(_bladeDepth, 2) * _calcVehicle.bladeWidth * nb + (_calcSoil.cohesion * _calcVehicle.bladeWidth * nc) + (_calcSoil.cohesion * _calcVehicle.TrackArea * nct) + (wv * nw);
    
    self.forceValue = prelim * KN_TO_KG;
    return self.forceValue;
    
}

-(double)MomentCapacity{
    double wv = _calcVehicle.vehicleWeight * KG_TO_KN;
    double top = (wv *(_calcVehicle.centerOfGravity * cos(_beta) - (_bladeDepth + _calcVehicle.centerofGravityHeight) * sin(_beta)) + [self Pp] * (_bladeDepth/3));
    
    double bot = cos(_theta - _beta) * (_bladeDepth + _anchorHeight) + sin(_theta - _beta) * _anchorSetback;
    
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

+(id)randomCalculation{
    Calculation *newCalc = [[self alloc]initWithCalcTitle:@"name"];
    return newCalc;
}

- (id)init {
    return [self initWithCalcTitle:@"title"];
}

- (id)initWithCalcTitle:(NSString *)itemTitle{
    self = [super init];
    
    if(self){
        self.title = itemTitle;
        self.creationDate = [[NSDate alloc]init];
        
        NSUUID *uuid = [[NSUUID alloc]init];
        NSString *key = [uuid UUIDString];
        _calcKey = key;
        _calcVehicle = [[Vehicle alloc]init];
        _calcSoil = [[Soil alloc]init];
        
    }
    return self;
}

-(void) dealloc{
    NSLog(@"Destroyed: %@",self);
}

@end
