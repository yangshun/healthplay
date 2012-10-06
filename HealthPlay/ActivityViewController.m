//
//  ActivityViewController.m
//  HealthPlay
//
//  Created by YangShun on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "ActivityViewController.h"
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
        self.foodRate = [[FoodRate alloc] initWithDelegate:self];
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

- (void) barcodeDetected:(ZBarSymbol *)barcode urlRequest:(NSURLRequest *)urlRequest
{
    ProductDescriptionController *productController = [[ProductDescriptionController alloc] initWithRequest:urlRequest];
    
    [self.foodRate.zbarController dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:productController animated:YES completion:nil];
    }];
}

- (IBAction)rateFood:(id)sender
{
    [self presentViewController:self.foodRate.zbarController animated:YES completion:nil];
}

@end
