//
//  Food.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodProduct : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) float calories;
@property (nonatomic, strong) UIImage *image;

- (id) initWithName:(NSString*)name calories:(float)calories imageData:(NSData*)imageData;

@end
