//
//  FoodPair.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodProduct.h"

@interface FoodPair : NSObject

@property (nonatomic) BOOL shouldFlip;

- (id) initWithProduct:(FoodProduct*)firstProduct andProduct:(FoodProduct*)secondProduct;
- (FoodProduct*) firstProduct;
- (FoodProduct*) secondProduct;
@end
