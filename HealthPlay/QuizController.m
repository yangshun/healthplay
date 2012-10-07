//
//  QuizController.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "QuizController.h"
#import "QuizObject.h"
#import "QuizScoreScreen.h"

@interface QuizController ()

@property (nonatomic, strong) NSMutableArray *questions;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic) int currentQuestion;
@property (nonatomic) int score;
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
        self.currentQuestion = 0;
        self.score = 0;
        
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
    self.buttons = [NSMutableArray arrayWithObjects:self.buttonOne, self.buttonTwo, self.buttonThree,nil];
    // Do any additional setup after loading the view from its nib.
    [self showNextQuestion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showNextQuestion {
    
    if (self.currentQuestion >= self.questions.count) {
        QuizScoreScreen *scoreScreen = [[QuizScoreScreen alloc] initWithScore:self.score];
        [self.navigationController pushViewController:scoreScreen animated:YES];
        return;
    }
    
    QuizObject *object = [self.questions objectAtIndex:self.currentQuestion];
    
    self.questionLabel.text = object.question;
    
    for (int i=0;i<3;i++) {
        UIButton *button = [self.buttons objectAtIndex:i];
        NSString *answer = [object.answers objectAtIndex:i];
        [button setTitle:answer forState:UIControlStateNormal];
    }
}

- (IBAction)selectedAnswer:(UIButton *)sender
{
    QuizObject *quiz = [self.questions objectAtIndex:self.currentQuestion];
    if (sender.tag == quiz.answer) {
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    }
    
    self.currentQuestion++;
    [self showNextQuestion];
}

@end
