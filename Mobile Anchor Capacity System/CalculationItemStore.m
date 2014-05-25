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

+ (instancetype)sharedStore
{
    static CalculationItemStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[CalculationItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[CalculationItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (Calculation *)createCalculation
{
    Calculation *item = [Calculation randomCalculation];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(Calculation *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    Calculation *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
