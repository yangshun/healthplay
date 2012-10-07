//
//  FoodMash.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "Constants.h"
#import "FoodMash.h"

@implementation FoodMash

+ (void) loadData:(void (^)(NSArray *))block
{
    NSURLRequest *urlRequest = [self constructInitialRequest];
}

+ (NSURLRequest*) constructInitialRequest
{
    NSString *apiKey = [NSString stringWithFormat:@"apikey=%@", FOODUCATE_API_KEY];
    NSString *reason = @"reason=scan";
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@&%@&%@",
                            FOODUCATE_PRODUCT_SEARCH_URL,
                            reason,
                            upc,
                            apiKey];
}

@end
