//
//  FoodMashCategoriesController.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodMashCategoriesController.h"
#import "FoodMashController.h"
#import "MBProgressHUD.h"
#import "FoodMash.h"

@interface FoodMashCategoriesController ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *categoryButtons;
@end

@implementation FoodMashCategoriesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSBundle* bundle = [NSBundle mainBundle];
        NSString* plistPath = [bundle pathForResource:@"FoodMashCategories" ofType:@"plist"];
        self.categories = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.categoryButtons = [[NSArray alloc] initWithObjects:self.categoryOne,
                            self.categoryTwo,
                            self.categoryThree,
                            self.categoryFour,
                            self.categoryFive,
                            self.categorySix,nil];

    for (int i=0;i<self.categoryButtons.count;i++) {
        UIButton *button = [self.categoryButtons objectAtIndex:i];
        NSDictionary *buttonInfo = [self.categories objectAtIndex:i];
        button.tag = i;
        
        button.titleLabel.text = [buttonInfo objectForKey:@"displayName"];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categorySelected:(UIButton *)sender
{
    NSDictionary *buttonInfo = [self.categories objectAtIndex:sender.tag];
    NSString *searchTerm = [buttonInfo objectForKey:@"searchTerm"];
    
    FoodMashController *controller = [[FoodMashController alloc] init];
    controller.searchTerm = searchTerm;
    [self showLoadingHUD];
    [FoodMash loadDataWithSearchTerm:searchTerm completion:^(NSArray *pairs) {
        [self hideLoadingHUD];
        if (pairs == nil) {
            // something went wrong
            return;
        }
        [self.navigationController pushViewController:controller animated:YES];
        controller.pairs = pairs;
        
        [controller showPair:0];
    }];
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

- (IBAction)backButtonPressed:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}


@end
