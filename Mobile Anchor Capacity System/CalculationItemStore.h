//
//  CalculationItemStore.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/23/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Calculation;

@interface CalculationItemStore : NSObject
@property(nonatomic,readonly) NSArray *allCalculations;
+(instancetype)sharedStore;
-(Calculation*)createCalculation;

@end
