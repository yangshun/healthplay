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
#import "Quiz.h"

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
  curYLoc = 0;
  [[self.feedView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  self.feedArray = nil;
  self.feedArray = [[NSMutableArray alloc] init];
  
  Food *food = [[Food alloc] init];
  [food list:nil onComplete:^(NSArray *respond) {
    NSLog(@"food count: %d", respond.count);
    for (id obj in respond) {
      [self.feedArray addObject:obj];
    }
    Mash *mash = [[Mash alloc] init];
    [mash list:nil onComplete:^(NSArray *respond) {
      NSLog(@"mash count: %d", respond.count);
      for (id obj in respond) {
        [self.feedArray addObject:obj];
      }
      Quiz *quiz = [[Quiz alloc] init];
      [quiz list:nil onComplete:^(NSArray *respond) {
        NSLog(@"quiz count: %d", respond.count);
        for (id obj in respond) {
          [self.feedArray addObject:obj];
        }
        [self sortFeed];
      } onFailure:^(NSError *error){}];
    } onFailure:^(NSError *error){}];
  } onFailure:^(NSError *error){}];
}

- (void)sortFeed {
//  [self.feedArray sortedArrayUsingSelector:@selector(compareThis:with:)];
  
  self.feedArray = [self.feedArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSDate *first = ((Food*)a).time;
    NSDate *second = ((Food*)b).time;
    return [first compare:second];
  }];
  
  for (int i = self.feedArray.count - 1; i>=0; i--) {
    if ([[self.feedArray objectAtIndex:i] isKindOfClass:[Food class]]) {
      Food *temp = [self.feedArray objectAtIndex:i];
      NSString *string = [NSString stringWithFormat:@"%@ won %d points for scanning %@!", [self nameFromUserid:temp._master_id], [temp.grade intValue], temp.name];
      UIView *view = [self createViewFromString:string andIndex:0];
      [self.feedView addSubview:view];
      view.frame = CGRectMake(0, curYLoc, view.frame.size.width, view.frame.size.height);
      curYLoc += view.frame.size.height + 15;
    } else if ([[self.feedArray objectAtIndex:i] isKindOfClass:[Mash class]]) {
      Mash *temp = [self.feedArray objectAtIndex:i];
      NSString *string = [NSString stringWithFormat:@"%@ scored %d points for playing %@ FoodMash!", [self nameFromUserid:temp._master_id], temp.points, temp.category];
      UIView *view = [self createViewFromString:string andIndex:0];
      [self.feedView addSubview:view];
      view.frame = CGRectMake(0, curYLoc, view.frame.size.width, view.frame.size.height);
      curYLoc += view.frame.size.height + 15;
    } else if ([[self.feedArray objectAtIndex:i] isKindOfClass:[Quiz class]]) {
      Quiz *temp = [self.feedArray objectAtIndex:i];
      NSString *string = [NSString stringWithFormat:@"%@ scored %d points in FoodQuiz!", [self nameFromUserid:temp._master_id], temp.score];
      UIView *view = [self createViewFromString:string andIndex:0];
      [self.feedView addSubview:view];
      view.frame = CGRectMake(0, curYLoc, view.frame.size.width, view.frame.size.height);
      curYLoc += view.frame.size.height + 15;
    }
      
  }
  self.feedView.contentSize = CGSizeMake(280, curYLoc);
}

- (UIView*)createViewFromString:(NSString*)string andIndex:(int)index {
  UIView *view = [[UIView alloc] init];
  view.frame = CGRectMake(0, 0, 280, 50);
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  NSString *imageName = [NSString stringWithFormat:@"thumbnail-%d", arc4random()%4 + 1];
  UIImage *thumbnail = [UIImage imageNamed:imageName];
  imgView.image = thumbnail;
  [view addSubview:imgView];
  
  UILabel *label = [[UILabel alloc] init];
  label.text = string;
  label.numberOfLines = 3;
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont boldSystemFontOfSize:16]];
  label.frame = CGRectMake(60, 0, 220, 50);
  label.textColor = [UIColor whiteColor];
  [view addSubview:label];
  return view;
}

- (NSString*)nameFromUserid:(NSString*)userid {
  NSArray *allUsers = ((NavigationViewController*)self.navigationController).allUsersArray;
  for (int i = 0; i < allUsers.count; i++) {
    User *currentUser = (User *)[allUsers objectAtIndex:i];
    if ([[currentUser getId] isEqualToString:userid]) {
      return currentUser.username;
    }
  }
  return @"Tom";
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
