//
//  FoodMashScoreScreen.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodMashScoreScreen.h"
#import "Mash.h"
#import "User.h"
#import "NavigationViewController.h"

@interface FoodMashScoreScreen () {
  
  IBOutlet UILabel *comment;
  IBOutlet UILabel *catLabel;
}

@property (nonatomic) int score;
@property (nonatomic) NSString *category;


@end

@implementation FoodMashScoreScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithScore:(int)score andCategory:(NSString *)category
{
    self = [self init];
    if (self) {
        self.score = score;
        self.category = category;
    }
    return self;
}

- (IBAction)submit:(id)sender {
  NSDate* now = [NSDate date];
  
  User *currUser = ((NavigationViewController*)(self.navigationController)).currUser;
  
  Mash *mash = [[Mash alloc]initWithMashCategory:self.category Points:self.score Time:now];
  [mash setUser:currUser];
  
  [mash saveWithCompletion:^(BOOL respond){} onFailure:^(NSError *respond){
    NSLog(@"Error saving mash: %@", respond.description);
  }];
  currUser.points += self.score;
  [currUser saveWithCompletion:^(BOOL completion){} onFailure:^(NSError *respond){}];
  UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
  [self.navigationController popToViewController:vc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
  if (self.score > 5) {
    comment.text = @"Good job! Try other categories!";
  } else {
    comment.text = @"Try harder next time...";
  }
  catLabel.text = [NSString stringWithFormat:@"for \'%@\' category.", self.category];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
