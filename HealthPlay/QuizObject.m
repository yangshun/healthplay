//
//  QuizObject.m
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "QuizObject.h"

@implementation QuizObject

- (id) initWithQuestion:(NSString*)question answers:(NSArray*)answers correctAnswer:(int)answer
{
    self = [super init];
    if (self) {
        self.question = question;
        self.answers = answers;
        self.answer = answer;
    }
    return self;
}

@end
