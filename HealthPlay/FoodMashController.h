//
//  FoodMashController.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodMashController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *firstButton;
@property (nonatomic, weak) IBOutlet UIButton *secondButton;

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *pairLabel;

- (IBAction)firstButtonSelected:(id)sender;
- (IBAction)secondButtonSelected:(id)sender;

@end
