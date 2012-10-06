//
//  ProductDescriptionController.m
//  FoodRate
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 PlayHealth. All rights reserved.
//

#import "ProductDescriptionController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface ProductDescriptionController ()
@property (nonatomic, strong) AFJSONRequestOperation *jsonRequest;
@end

@implementation ProductDescriptionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithRequest:(NSURLRequest*)request
{
    self = [self init];
    if (self) {
        self.jsonRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [self hideLoadingHUD];
            
            NSString *name = [JSON valueForKeyPath:@"name"];
            NSString *imageURL = [JSON valueForKeyPath:@"image"];
            
            id grade = [JSON valueForKeyPath:@"fooducateGrade"];
            NSString *grade_score = [grade valueForKeyPath:@"score"];
            
            self.productName.text = name;
            self.productGrade.text = grade_score;
            
            NSURL *url = [NSURL URLWithString:imageURL];
            self.productImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            [self hideLoadingHUD];
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error loading this item!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self showLoadingHUD];
    [self.jsonRequest start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
