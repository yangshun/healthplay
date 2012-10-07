//
//  NavigationViewController.h
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "User.h"

@interface NavigationViewController : UINavigationController

@property (strong, nonatomic) User *currUser;

@end
