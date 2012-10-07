//
//  FoodMash.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodMash : NSObject

+ (void) loadDataWithSearchTerm:(NSString*)searchTerm completion:(void(^)(NSArray* pairs))block;

@end
