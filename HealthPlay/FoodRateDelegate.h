//
//  FoodRateDelegate.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBarSDK.h"

@protocol FoodRateDelegate <NSObject>

- (void) barcodeDetected:(ZBarSymbol*)barcode urlRequest:(NSURLRequest*)urlRequest;

@end
