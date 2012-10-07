//
//  ProfileViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "ProfileViewController.h"
#import "NavigationViewController.h"

@interface ProfileViewController () {
  IBOutlet UILabel *nameLabel;
  IBOutlet UIScrollView *_scrollView;
  UIImage *boy1;
  UIImage *boy2;
  UIImage *girl1;
  UIImage *girl2;
  NSArray *avatarImages;
  int avatarIndex;
  NSMutableArray *avatarImageViews;
  
}

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      boy1 = [UIImage imageNamed:@"boy-1.png"];
      boy2 = [UIImage imageNamed:@"boy-2.png"];
      girl1 = [UIImage imageNamed:@"girl-1.png"];
      girl2 = [UIImage imageNamed:@"girl-2.png"];
      avatarImages = [NSArray arrayWithObjects:boy1, boy2, girl1, girl2, nil];
      avatarImageViews = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  CGFloat curXLoc = 0;
  for (UIImage *img in avatarImages) {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [avatarImageViews addObject:imgView];
    [_scrollView addSubview:imgView];
    imgView.frame = CGRectMake(curXLoc, 0, 106, 200);
    curXLoc += 106;
  }
  _scrollView.delegate = self;
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(curXLoc, 200);
  // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  nameLabel.text = ((NavigationViewController*)(self.navigationController)).username;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  int page = floor((scrollView.contentOffset.x - 106 / 2) / 106) + 1;
//  NSLog(@"%d", page);
//  CGRect frame;
//	frame.origin.x = scrollView.frame.size.width * page;
//	frame.origin.y = 0;
//	frame.size = scrollView.frame.size;
//	[scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
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
