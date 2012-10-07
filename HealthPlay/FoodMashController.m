//
//  FoodMashController.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodMash.h"
#import "FoodMashController.h"
#import "MBProgressHUD.h"
#import "FoodPair.h"

@interface FoodMashController ()
@property (nonatomic, strong) FoodPair *currentPair;
@property (nonatomic, strong) NSArray *pairs;
@end

@implementation FoodMashController

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
    
    [self showLoadingHUD];
    [FoodMash loadDataWithSearchTerm:@"bars" completion:^(NSArray *pairs) {
        [self hideLoadingHUD];
        
        if (pairs == nil) {
            // something went wrong
            return;
        }
        self.pairs = pairs;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void) showLoadingHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) hideLoadingHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
@end
