//
//  FoodMashCategoriesController.h
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodMashCategoriesController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *categoryOne;
@property (nonatomic, weak) IBOutlet UIButton *categoryTwo;
@property (nonatomic, weak) IBOutlet UIButton *categoryThree;
@property (nonatomic, weak) IBOutlet UIButton *categoryFour;
@property (nonatomic, weak) IBOutlet UIButton *categoryFive;
@property (nonatomic, weak) IBOutlet UIButton *categorySix;

- (IBAction)categorySelected:(UIButton*)sender;

@end
