//
//  ViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "ViewController.h"
#import "NavigationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.nameLabel.text = ((NavigationViewController*)(self.navigationController)).username;
  NSLog(@"curr user:%@", ((NavigationViewController*)(self.navigationController)).username);
}

- (IBAction)pushProfile:(id)sender {
  ProfileViewController *profilevc = [[ProfileViewController alloc] init];
  [self.navigationController pushViewController:profilevc animated:YES];
}

- (IBAction)pushActivity:(id)sender {
  ActivityViewController *activityvc = [[ActivityViewController alloc] init];
  [self.navigationController pushViewController:activityvc animated:YES];
}

- (IBAction)logout:(id)sender {
  ((NavigationViewController*)(self.navigationController)).username = @"";
  ((NavigationViewController*)(self.navigationController)).userid = @"";
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushPreGame:(id)sender {
  PreGameViewController *pregamevc = [[PreGameViewController alloc] init];
  [self.navigationController pushViewController:pregamevc animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
