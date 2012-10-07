//
//  FoodPair.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodPair.h"

@interface FoodPair ()
@property (nonatomic, strong) FoodProduct *answerProduct;
@property (nonatomic, strong) FoodProduct *otherProduct;
@end

@implementation FoodPair

- (id) initWithProduct:(FoodProduct *)firstProduct andProduct:(FoodProduct *)secondProduct
{
    self = [super init];
    if (self) {
        if (firstProduct.calories < secondProduct.calories) {
            self.answerProduct = firstProduct;
            self.otherProduct = secondProduct;
        } else {
            self.answerProduct = secondProduct;
            self.otherProduct = firstProduct;
        }

        self.shouldFlip = ((arc4random()%2) == 0);
    }

    return self;
}

- (FoodProduct*) firstProduct {
    if (self.shouldFlip) {
        return self.otherProduct;
    }
    return self.answerProduct;
}

- (FoodProduct*) secondProduct {
    if (self.shouldFlip) {
        return self.answerProduct;
    }
    return self.otherProduct;
}

@end
