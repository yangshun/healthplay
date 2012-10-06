//
//  ViewController.h
//  FoodRate
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 PlayHealth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController<ZBarReaderDelegate>


- (IBAction)launchZBar:(id)sender;

@end
