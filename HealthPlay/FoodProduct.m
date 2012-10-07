//
//  Food.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodProduct.h"

@implementation FoodProduct

- (id) initWithName:(NSString *)name calories:(float)calories imageData:(NSData *)imageData
{
    self = [super init];
    if (self) {
        self.name = name;
        self.calories = calories;
        self.image = [UIImage imageWithData:imageData];
    }
    return self;
}

@end
