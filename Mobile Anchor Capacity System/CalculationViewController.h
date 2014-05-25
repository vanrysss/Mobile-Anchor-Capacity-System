//
//  CalculationViewController.h
//  Mobile Anchor Capacity System
//
//  Created by Sam Van Ryssegem on 5/22/14.
//  Copyright (c) 2014 VanR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculation;

@interface CalculationViewController : UIViewController

@property (nonatomic,strong) Calculation *calculation;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;


@end
