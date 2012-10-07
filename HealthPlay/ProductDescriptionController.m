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
#import "Food.h"
#import "User.h"
#import "NavigationViewController.h"

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
            self.imageURL = [JSON valueForKeyPath:@"image"];
            
            id grade = [JSON valueForKeyPath:@"fooducateGrade"];
            NSString *grade_score = [grade valueForKeyPath:@"score"];
            
            self.productName.text = name;
            self.productGrade.text = grade_score;
            
            NSURL *url = [NSURL URLWithString:self.imageURL];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            self.productImageView.image = image;
            NSLog(@"image size: %@", NSStringFromCGSize(image.size));
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            [self hideLoadingHUD];
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error loading this item!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)submit:(id)sender {
  NSDate* now = [NSDate date];
  
  User *currUser = ((NavigationViewController*)(self.navigationController)).currUser;
  NSString *userid = [currUser getId];
  Food *food = [[Food alloc]initWithFoodName:self.productName.text
                                       Grade:self.productGrade.text
                                        Time:now
                                    Imageurl:self.imageURL];
  NSLog(@"hello");
  NSLog(@"product name: %@", self.productName.text);
  NSLog(@"grade: %@", self.productGrade.text);
  NSLog(@"url: %@", self.imageURL);
  NSLog(@"userid: %@", userid);
  NSLog(@"bye");
  [food setUser:currUser];

  [food saveWithCompletion:^(BOOL respond){} onFailure:^(NSError *respond){
      NSLog(@"Error saving food: %@", respond.description);
  }];
  currUser.points += [self.productGrade.text intValue];
  [currUser saveWithCompletion:^(BOOL completion){} onFailure:^(NSError *respond){}];
  UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
  [self.navigationController popToViewController:vc animated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
