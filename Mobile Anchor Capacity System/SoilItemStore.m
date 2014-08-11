//
//  SoilItemStore.m
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 8/10/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import "SoilItemStore.h"
#import "Soil.h"

@interface SoilItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation SoilItemStore

+ (instancetype)sharedStore
{
    static SoilItemStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[SoilItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[SoilItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (Soil *)createSoil
{
    Soil *item = [[Soil alloc]init];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(Soil *)item
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
    Soil *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

-(NSString*)itemArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

-(BOOL)saveChanges{
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}


@end
