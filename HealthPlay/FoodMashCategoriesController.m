//
//  FoodMashCategoriesController.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodMashCategoriesController.h"

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
        
        self.categoryButtons = [[NSArray alloc] initWithObjects:self.categoryOne,
                                                                self.categoryTwo,
                                                                self.categoryThree,
                                                                self.categoryFour,
                                                                self.categoryFive,
                                                                self.categorySix,nil];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (int i=0;i<self.categoryButtons.count;i++) {
        UIButton *button = [self.categoryButtons objectAtIndex:i];
        button.tag = i;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
