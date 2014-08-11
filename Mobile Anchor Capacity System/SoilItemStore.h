//
//  SoilItemStore.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 8/10/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soil.h"
@interface SoilItemStore : NSObject

@property(nonatomic,readonly) NSArray *allSoils;

+(instancetype)sharedStore;
-(Soil *)createSoil;
-(void)removeItem:(Soil *)item;
-(void)moveItemAtIndex:(NSInteger)fromIndex
               toIndex:(NSInteger)toIndex;
-(BOOL)saveChanges;

@end
