//
//  FoodRate.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBarSDK.h"
#import "FoodRateDelegate.h"

@interface FoodRate : NSObject<ZBarReaderDelegate>

- (id) initWithDelegate:(id<FoodRateDelegate>)delegate;
- (ZBarReaderViewController*) zbarController;


@property (nonatomic, strong) id<FoodRateDelegate> delegate;
@property (nonatomic, strong) ZBarReaderViewController *zbarController;

@end
