//
//  ViewController.h
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "ActivityViewController.h"
#import "PreGameViewController.h"

@interface ViewController : UIViewController {
  CGFloat curYLoc;
}

- (IBAction)pushProfile:(id)sender;
- (IBAction)pushActivity:(id)sender;
- (IBAction)pushPreGame:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *feedView;
@property (strong, nonatomic) NSMutableArray *feedArray;

@end
