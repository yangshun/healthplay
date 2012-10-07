//
//  QuizScoreScreen.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "QuizScoreScreen.h"
#import "User.h"
#import "Quiz.h"
#import "NavigationViewController.h"

@interface QuizScoreScreen ()

@property (nonatomic) int score;
@end

@implementation QuizScoreScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithScore:(int)score
{
    self = [self init];
    if (self) {
        self.score = score;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
  NSDate* now = [NSDate date];
  
  User *currUser = ((NavigationViewController*)(self.navigationController)).currUser;
  
  Quiz *quiz = [[Quiz alloc]initWithQuizScore:self.score Points:nil Time:now];
  [quiz setUser:currUser];
  
  [quiz saveWithCompletion:^(BOOL respond){} onFailure:^(NSError *respond){
    NSLog(@"Error saving quiz: %@", respond.description);
  }];
  currUser.points += self.score;
  [currUser saveWithCompletion:^(BOOL completion){} onFailure:^(NSError *respond){}];
  UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
  [self.navigationController popToViewController:vc animated:YES];
}

@end
