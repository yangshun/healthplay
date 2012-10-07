//
//  GameViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "GameViewController.h"
#import "NavigationViewController.h"

@interface GameViewController () {
  IBOutlet UILabel *heartQty;
  IBOutlet UILabel *potionQty;
  IBOutlet UILabel *score;
}

@end

@implementation GameViewController

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
  score.text = [NSString stringWithFormat:@"%d", ((NavigationViewController*)self.navigationController).currUser.points];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)increaseHearts:(id)sender {
  heartQty.text = [NSString stringWithFormat:@"%d", [heartQty.text intValue] + 1];
  score.text = [NSString stringWithFormat:@"%d", [score.text intValue] - 2];
}

- (IBAction)increasePotions:(id)sender {
  potionQty.text = [NSString stringWithFormat:@"%d", [potionQty.text intValue] + 1];
  score.text = [NSString stringWithFormat:@"%d", [score.text intValue] - 3];
}

- (IBAction)startgame:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"bomberman://"]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
