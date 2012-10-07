//
//  ActivityViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "ActivityViewController.h"
#import "FoodMashCategoriesController.h"
#import "ProductDescriptionController.h"
#import "QuizController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface ActivityViewController ()
@property (nonatomic, strong) FoodRate *foodRate;
@end

@implementation ActivityViewController

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

- (IBAction)startFoodRate:(id)sender
{
    self.foodRate = [[FoodRate alloc] initWithDelegate:self];
    [self presentViewController:self.foodRate.zbarController animated:YES completion:nil];
}

- (IBAction)startFoodMash:(id)sender
{
    FoodMashCategoriesController *controller = [[FoodMashCategoriesController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)startQuiz:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://giftsy.co/healthplay/getquestion.php"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *jsonRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self hideLoadingHUD];
        QuizController *controller = [[QuizController alloc] initWithJSON:JSON];
        [self.navigationController pushViewController:controller animated:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", [error localizedDescription]);
        [self hideLoadingHUD];
    }];
    
    [self showLoadingHUD];
    [jsonRequest start];
}

- (IBAction)backButtonPressed:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark FoodRate delegate
- (void) barcodeDetected:(ZBarSymbol *)barcode urlRequest:(NSURLRequest *)urlRequest
{
    ProductDescriptionController *productController = [[ProductDescriptionController alloc] initWithRequest:urlRequest];
    
    [self.foodRate.zbarController dismissViewControllerAnimated:NO completion:^{
        [self.navigationController pushViewController:productController animated:NO];
    }];
}


@end
