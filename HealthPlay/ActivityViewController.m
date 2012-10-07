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
    [self.navigationController pushViewController:self.foodRate.zbarController animated:YES];
}

- (IBAction)startFoodMash:(id)sender
{
    FoodMashCategoriesController *controller = [[FoodMashCategoriesController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark FoodRate delegate
- (void) barcodeDetected:(ZBarSymbol *)barcode urlRequest:(NSURLRequest *)urlRequest
{
    ProductDescriptionController *productController = [[ProductDescriptionController alloc] initWithRequest:urlRequest];
    
    [self.foodRate.zbarController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController pushViewController:productController animated:YES];
    }];
}


@end
