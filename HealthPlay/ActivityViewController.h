//
//  ActivityViewController.h
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodRate.h"

@interface ActivityViewController : UIViewController<FoodRateDelegate>

- (IBAction)rateFood:(id)sender;

@end
