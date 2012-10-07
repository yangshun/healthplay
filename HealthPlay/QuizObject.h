//
//  QuizObject.h
//  HealthPlay
//
//  Created by soedar on 7/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizObject : NSObject
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic) int answer;

- (id) initWithQuestion:(NSString*)question answers:(NSArray*)answers correctAnswer:(int)answer;

@end
