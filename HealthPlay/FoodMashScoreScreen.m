//
//  FoodMashScoreScreen.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodMashScoreScreen.h"

@interface FoodMashScoreScreen ()
@property (nonatomic) int score;
@property (nonatomic) NSString *category;
@end

@implementation FoodMashScoreScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithScore:(int)score andCategory:(NSString *)category
{
    self = [self init];
    if (self) {
        self.score = score;
        self.category = category;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    
    NSLog(@"Category: %@", self.category);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
