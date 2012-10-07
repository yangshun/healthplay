//
//  QuizController.h
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
@property (nonatomic, weak) IBOutlet UIButton *buttonTwo;
@property (nonatomic, weak) IBOutlet UIButton *buttonThree;

- (id) initWithJSON:(id)JSON;
@end
