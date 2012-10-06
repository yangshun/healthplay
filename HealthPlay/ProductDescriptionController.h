//
//  ProductDescriptionController.h
//  FoodRate
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 PlayHealth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDescriptionController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *productName;
@property (nonatomic, weak) IBOutlet UILabel *productGrade;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;

- (id) initWithRequest:(NSURLRequest*)request;
- (IBAction)backButtonPressed:(id)sender;

@end
