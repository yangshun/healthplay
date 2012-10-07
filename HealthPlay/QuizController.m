//
//  QuizController.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "QuizController.h"
#import "QuizObject.h"

@interface QuizController ()

@property (nonatomic, strong) NSMutableArray *questions;
@end

@implementation QuizController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithJSON:(id)JSON
{
    self = [self init];
    if (self) {
        self.questions = [NSMutableArray array];
        
        NSArray *questions = [JSON objectForKey:@"questions"];
        NSArray *choiceA = [JSON objectForKey:@"choicea"];
        NSArray *choiceB = [JSON objectForKey:@"choiceb"];
        NSArray *choiceC = [JSON objectForKey:@"choicec"];
        NSArray *answer = [JSON objectForKey:@"answer"];
        int count = [[JSON objectForKey:@"total_number"] intValue];;
        
        for (int i=0;i<count;i++) {
            NSString *question = [questions objectAtIndex:i];
            NSString *a = [choiceA objectAtIndex:i];
            NSString *b = [choiceB objectAtIndex:i];
            NSString *c = [choiceC objectAtIndex:i];
            int ans = [[answer objectAtIndex:i] intValue];
            
            NSArray *choices = [NSArray arrayWithObjects:a,b,c,nil];
            
            QuizObject *quiz = [[QuizObject alloc] initWithQuestion:question answers:choices correctAnswer:ans];
            [self.questions addObject:quiz];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
