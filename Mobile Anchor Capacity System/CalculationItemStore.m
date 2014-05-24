//
//  CalculationItemStore.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/23/14.
//  Copyright (c) 2014 VanR. All rights reserved.
// Responsible for handling the singleton which stores calculaiton objects

#import "CalculationItemStore.h"
#import "Calculation.h"

@interface CalculationItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation CalculationItemStore

+(instancetype)sharedStore{
    
    static CalculationItemStore *sharedStore =nil;
    
    //do I need to create one?
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
    }
    return sharedStore;
}
-(instancetype)init{
    
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [CalculaitonItemStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray*) allItems{
    return self.privateItems;
}

-(Calculation*)createCalculation{
    Calculation *item = [Calculation init];
    [self.privateItems addObject:item];
    return item;
}
@end
