//
//  LoginViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "NavigationViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "ViewController.h"

@interface LoginViewController () {
  
  IBOutlet UITextField *username;
  IBOutlet UITextField *password;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)registerNewUser:(id)sender {
  NSString *userString = username.text;
  NSString *passwordString = password.text;
  User *newUser = [[User alloc] initWithUserAvatarid:1 Username:userString Password:passwordString];
  [newUser saveWithCompletion:^(BOOL respond) {
    NSLog(@"Signup successful.");
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    ((NavigationViewController*)(self.navigationController)).username = userString;
    ((NavigationViewController*)(self.navigationController)).userid = [newUser getId];
    NSLog(@"new user id:%@", [newUser getId]);
  } onFailure:^(NSError *respond) {
    NSLog(@"Error sign up %@", respond.description);
  }];

}

- (IBAction)login:(id)sender {
  
  NSString *userString = username.text;
  NSString *passwordString = password.text;
  
  User* newUser = [[User alloc] init];
  
  User *user = [[User alloc] init];
  [user list:nil onComplete:^(NSArray *respond) {
    NSLog(@"Total users: %d", [respond count]);
    BOOL userMatched = NO;
    for (int i = 0; i < [respond count]; i++) {
      User *currentUser = (User *)[respond objectAtIndex:i];
      
      if ([currentUser.username isEqualToString:userString] &&
          [currentUser.password isEqualToString:passwordString]) {
        ((NavigationViewController*)(self.navigationController)).username = userString;
        ((NavigationViewController*)(self.navigationController)).userid = [currentUser getId];
        NSLog(@"user id: %@", [currentUser getId]);
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        userMatched = YES;
        break;
      }
    }
    if (!userMatched) {
      UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Login error"
                                                      message:@"Your password is incorrect" delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles: nil];
      [error show];
    }
  } onFailure:^(NSError *respond) {
    NSLog(@"List error: %@", respond.description);
  }];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
