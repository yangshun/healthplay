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

- (IBAction)startFoodRate:(id)sender;
- (IBAction)startFoodMash:(id)sender;
- (IBAction)startQuiz:(id)sender;
@end
