//
//  VehicleItemStore.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 8/10/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@interface VehicleItemStore : NSObject
@property(nonatomic,readonly) NSArray *allSoils;

+(instancetype)sharedStore;
-(Vehicle *)createVehicle;
-(void)removeItem:(Vehicle *)item;
-(void)moveItemAtIndex:(NSInteger)fromIndex
               toIndex:(NSInteger)toIndex;
-(BOOL)saveChanges;
@end
