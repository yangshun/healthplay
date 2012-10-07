//
//  FoodMash.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "Constants.h"
#import "FoodProduct.h"
#import "FoodMash.h"
#import "AFNetworking.h"
#import "FoodPair.h"

#define MAX_COUNT           40

@implementation FoodMash

+ (void) loadDataWithSearchTerm:(NSString*)searchTerm completion:(void (^)(NSArray *))block
{
    NSURLRequest *urlRequest = [self constructInitialRequest:searchTerm];
    [self loadJsonRequest:urlRequest completion:block];
}

+ (NSURLRequest*) constructInitialRequest:(NSString*)searchTerm
{
    NSString *apiKey = [NSString stringWithFormat:@"apikey=%@", FOODUCATE_API_KEY];
    NSString *search = [NSString stringWithFormat:@"searchterm=%@", searchTerm];
    NSString *count = [NSString stringWithFormat:@"count=%i", MAX_COUNT];
    NSString *offset = [NSString stringWithFormat:@"offset=%i", 0];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@&%@&%@&%@",
                            FOODUCATE_PRODUCT_SEARCH_URL,
                            search,
                            count,
                            offset,
                            apiKey];
    
    NSLog(@"%@", requestUrl);
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    return [NSURLRequest requestWithURL:url];
}

+ (void) loadJsonRequest:(NSURLRequest*)urlRequest completion:(void (^)(NSArray *))block
{
    AFJSONRequestOperation *jsonRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self prepareJsonData:JSON completion:block];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error fetching request: %@", [error localizedDescription]);
        block(nil);
    }];
    
    [jsonRequest start];
}

+ (void) prepareJsonData:(id)JSON completion:(void(^)(NSArray*))block
{
    NSMutableArray *productsPair = [NSMutableArray array];
    
    NSMutableArray *products = [NSMutableArray array];
    for (int i=0;i<MAX_COUNT;i++) {
        id product = [JSON objectAtIndex:i];
        NSString *name = [product objectForKey:@"name"];
        
        NSURL *imageURL = [NSURL URLWithString:[product objectForKey:@"image"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        id serving = [product objectForKey:@"fooducateServing"];
        float calories = [[serving objectForKey:@"calories"] floatValue];
        
        FoodProduct *food = [[FoodProduct alloc] initWithName:name calories:calories imageData:imageData];
        [products addObject:food];
    }
    
    // Shuffle array
    for (NSUInteger i = 0; i < products.count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = products.count - i;
        int n = (arc4random() % nElements) + i;
        [products exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    for (int i=0;i<FOODMASH_ROUNDS;i++) {
        FoodProduct *a = [products objectAtIndex:i*2];
        FoodProduct *b = [products objectAtIndex:i*2+1];
        FoodPair *foodPair = [[FoodPair alloc] initWithProduct:a andProduct:b];
        
        [productsPair addObject:foodPair];
    }
    block(productsPair);
}

@end
