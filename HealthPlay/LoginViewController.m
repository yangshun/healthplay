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

#define kOFFSET_FOR_KEYBOARD 216.0

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
  
  [username resignFirstResponder];
  [password resignFirstResponder];
  
  NSString *userString = username.text;
  NSString *passwordString = password.text;
  
  User *newUser = [[User alloc] initWithUserUsername:userString Password:passwordString Points:0];
  [newUser saveWithCompletion:^(BOOL respond) {
    NSLog(@"Signup successful.");
    ((NavigationViewController*)(self.navigationController)).currUser = newUser;
    
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"new user id:%@", [newUser getId]);
  } onFailure:^(NSError *respond) {
    NSLog(@"Error sign up %@", respond.description);
  }];

}

- (IBAction)login:(id)sender {
  
  [username resignFirstResponder];
  [password resignFirstResponder];
  
  NSString *userString = username.text;
  NSString *passwordString = password.text;
  
  User *user = [[User alloc] init];
  [user list:nil onComplete:^(NSArray *respond) {
    ((NavigationViewController*)(self.navigationController)).allUsersArray = respond;
    NSLog(@"Total users: %d", [respond count]);
    BOOL userMatched = NO;
    for (int i = 0; i < [respond count]; i++) {
      User *currentUser = (User *)[respond objectAtIndex:i];
      
      if ([currentUser.username isEqualToString:userString] &&
          [currentUser.password isEqualToString:passwordString]) {
        ((NavigationViewController*)(self.navigationController)).currUser = currentUser;
        
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


-(void)keyboardWillShow {
  // Animate the current view out of the way
  if (self.view.frame.origin.y >= 0)
  {
    [self setViewMovedUp:YES];
  }
  else if (self.view.frame.origin.y < 0)
  {
    [self setViewMovedUp:NO];
  }
}

-(void)keyboardWillHide {
  if (self.view.frame.origin.y >= 0)
  {
    [self setViewMovedUp:YES];
  }
  else if (self.view.frame.origin.y < 0)
  {
    [self setViewMovedUp:NO];
  }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
  if ([sender isEqual:username] || [sender isEqual:password])
  {
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
      [self setViewMovedUp:YES];
    }
  }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.25]; // if you want to slide up the view
  
  CGRect rect = self.view.frame;
  if (movedUp)
  {
    // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
    // 2. increase the size of the view so that the area behind the keyboard is covered up.
    rect.origin.y -= kOFFSET_FOR_KEYBOARD;
  }
  else
  {
    // revert back to the normal state.
    rect.origin.y += kOFFSET_FOR_KEYBOARD;
  }
  self.view.frame = rect;
  
  [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated
{
  // register for keyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  username.text = @"";
  password.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated
{
  // unregister for keyboard notifications while not visible.
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
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
