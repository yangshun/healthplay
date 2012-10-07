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
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@interface FoodMashController ()
@property (nonatomic) int currentPair;
@property (nonatomic) int score;
@property (nonatomic, strong) NSArray *pairs;
@end

@implementation FoodMashController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentPair = 0;
        self.score = 0;
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
        [self showPairs:self.currentPair];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showPairs:(int)pairId
{
    float width = self.firstLabel.frame.size.width;
    
    self.pairLabel.text = [NSString stringWithFormat:@"%i", pairId+1];
    
    
    FoodPair *pair = [self.pairs objectAtIndex:pairId];
    [self.firstButton setImage:pair.firstProduct.image forState:UIControlStateNormal];
    [self.firstButton setImage:pair.firstProduct.image forState:UIControlStateHighlighted];
    self.firstButton.layer.borderWidth = 0;
    [self.firstLabel setText:pair.firstProduct.name];
    
    
    [self.secondButton setImage:pair.secondProduct.image forState:UIControlStateNormal];
    [self.secondButton setImage:pair.secondProduct.image forState:UIControlStateHighlighted];
    self.secondButton.layer.borderWidth = 0;
    [self.secondLabel setText:pair.secondProduct.name];
    
    [self.firstLabel sizeToFit];
    CGRect rect = self.firstLabel.frame;
    self.firstLabel.frame = CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
    
    [self.secondLabel sizeToFit];
    rect = self.secondLabel.frame;
    self.secondLabel.frame = CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
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

- (void) nextRound {
    self.currentPair++;
    if (self.currentPair >= FOODMASH_ROUNDS) {
        self.firstButton.hidden = YES;
        self.secondButton.hidden = YES;
        return;
    }
    [self showPairs:self.currentPair];
}

- (IBAction)firstButtonSelected:(id)sender {
    FoodPair *pair = [self.pairs objectAtIndex:self.currentPair];
    
    if (!pair.shouldFlip) {
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    }
    [self nextRound];
}
- (IBAction)secondButtonSelected:(id)sender {
    FoodPair *pair = [self.pairs objectAtIndex:self.currentPair];
    
    if (pair.shouldFlip) {
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    }
    [self nextRound];
}
@end
