//
//  Calculation.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "Calculation.h"
#import <Foundation/Foundation.h>

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

@interface Calculation()
@property (nonatomic, strong) NSDate *creationDate;

@end

@implementation Calculation


-(double)Alpha1{
    
    double rbeta= degreesToRadians(_beta);
    double rdelta = degreesToRadians(_delta);
    
       NSLog(@" rbeta %f", rbeta);
       NSLog(@" rdelta %f", rdelta);

    
    
    double top = cos(rbeta) - tan(rdelta) * sin(rbeta);
    double bot = sin(rbeta) + tan(rdelta) * cos(rbeta);
    
    return (sin(rbeta) + cos(rbeta) * (top/bot));
}

-(double)Alpha2{
    
    double top = cos(degreesToRadians(_beta)) - tan(degreesToRadians(_delta)) * sin(degreesToRadians(_beta));
    double bot = sin(degreesToRadians(_beta)) + tan(degreesToRadians(_delta)) * cos(degreesToRadians(_beta));
    
    return sin(degreesToRadians(_beta)) + sin(degreesToRadians(_theta)) *(top/bot);

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
    
    double alph1 =[self Alpha1];
    double alph2 = [self Alpha2];
    
    _Kp = pow(tan((45.0+ degreesToRadians(_calcSoil.frictionAngle)/2.0)), 2);
    if (_theta - _beta >= _delta) {
        _Kp=0;
    }else if (_theta - _beta >0){
        _Kp = 0.5 * _Kp;
    }
    
    double gamma = _calcSoil.unitWeight * KG_TO_KN;
    double wb = _calcVehicle.bladeWidth;
    double nb = _Kp * alph1;
    double nc = 2 * sqrt(_Kp) * alph1;
    double nct = alph1 / alph2;
    double nw = 1/alph2;
    double wv = _calcVehicle.vehicleWeight * KG_TO_KN;
    double trackArea = _calcVehicle.TrackArea;
    
    double prelim = 0.5 * gamma * pow(_bladeDepth, 2) * wb * nb + (_calcSoil.cohesion * wb * nc) + (_calcSoil.cohesion * trackArea * nct) + (wv * nw);
    
    self.forceValue = prelim * KN_TO_KG;
    
    //log for error checking
    NSLog(@" Alph1 %f", alph1);
    NSLog(@" Alph2 %f", alph2);
    NSLog(@" Kp %f", _Kp);
    NSLog(@" delta %f", _delta);
    NSLog(@" gamma %f", gamma);
    NSLog(@" nb %f", nb);
    NSLog(@" nc %f", nc);
    NSLog(@" nct %f", nct);
    NSLog(@" nw %f", nw);
    NSLog(@" wv %f", wv);
    NSLog(@"%f", prelim);
    
    return self.forceValue;
    
}

-(double)MomentCapacity{
    double wv = _calcVehicle.vehicleWeight * KG_TO_KN;
    double top = (wv *(_calcVehicle.centerOfGravity * cos(degreesToRadians(_beta)) - (_bladeDepth + _calcVehicle.centerofGravityHeight) * sin(degreesToRadians(_beta))) + [self Pp] * (_bladeDepth/3));
    
    double bot = cos(degreesToRadians(_theta - _beta)) * (_bladeDepth + _anchorHeight) + sin(degreesToRadians(_theta - _beta)) * _anchorSetback;
    
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
