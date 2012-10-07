//
//  ViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "ViewController.h"
#import "NavigationViewController.h"
#import "Food.h"
#import "Mash.h"
#import "User.h"

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
  
  self.feedArray = nil;
  self.feedArray = [[NSMutableArray alloc] init];
  
  Food *food = [[Food alloc] init];
  [food list:nil onComplete:^(NSArray *respond) {
    for (id obj in respond) {
      [self.feedArray addObject:obj];
    }
  } onFailure:^(NSError *error){}];
  
  Mash *mash = [[Mash alloc] init];
  [mash list:nil onComplete:^(NSArray *respond) {
    for (id obj in respond) {
      [self.feedArray addObject:obj];
    }
    [self sortFeed];
  } onFailure:^(NSError *error){}];
  
}

- (void)sortFeed {
//  [self.feedArray sortedArrayUsingSelector:@selector(compareThis:with:)];
  
  self.feedArray = [self.feedArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSDate *first = ((Food*)a).time;
    NSDate *second = ((Food*)b).time;
    return [first compare:second];
  }];
  
  for (int i = 0; i < self.feedArray.count; i++) {
    if ([[self.feedArray objectAtIndex:i] isKindOfClass:[Food class]]) {
      Food *temp = [self.feedArray objectAtIndex:i];
      NSLog(@"Food name: %@, time: %@, name: %@", temp.name, temp.time, [self nameFromUserid:temp._master_id]);
    } else if ([[self.feedArray objectAtIndex:i] isKindOfClass:[Mash class]]) {
      Mash *temp = [self.feedArray objectAtIndex:i];
      NSLog(@"Mash cat: %@, time: %@, points: %d, name: %@", temp.category, temp.time, temp.points, [self nameFromUserid:temp._master_id]);
    }
  }
}

- (UIView*)createViewFromItem {
  UIView *view = [[UIView alloc] init];
  view.frame = CGRectMake(0, 0, 280, 50);
  UIImageView *imgView;
}

- (NSString*)nameFromUserid:(NSString*)userid {
  NSArray *allUsers = ((NavigationViewController*)self.navigationController).allUsersArray;
  NSLog(@"%d", allUsers.count);
  for (int i = 0; i < allUsers.count; i++) {
    User *currentUser = (User *)[allUsers objectAtIndex:i];
    if ([[currentUser getId] isEqualToString:userid]) {
      return currentUser.username;
    }
  }
}

- (NSComparisonResult)compareThis:(id)obj1 with:(id)obj2 {
  return [((Food*)obj1).time compare:((Food*)obj2).time];
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
  ((NavigationViewController*)(self.navigationController)).currUser = nil;
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
