//
//  FoodMashScoreScreen.h
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodMashScoreScreen : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

- (id)initWithScore:(int)score;

@end
