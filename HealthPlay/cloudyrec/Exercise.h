//
//  Exercise.h
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudyRecResource.h"
#import "User.h"
@interface Exercise : CloudyRecResource
{
  @private
  NSString* exerciseResKey;
  NSString* _master_id;
  NSString* distance;
  NSString* points;
  NSDate* time;
  NSString* user;
  NSString* frienduser;
  int type;

}

@property(nonatomic,retain) NSString *exerciseResKey;
@property(nonatomic,retain) NSString *_master_id;
@property(nonatomic,retain) NSString *distance;
@property(nonatomic,retain) NSString *points;
@property(nonatomic,retain) NSDate *time;
@property(nonatomic,retain) NSString *user;
@property(nonatomic,retain) NSString *frienduser;
@property(nonatomic,assign) int type;


-(id)initWithExerciseDistance:(NSString*)distance_ Points:(NSString*)points_ Time:(NSDate*)time_ User:(NSString*)user_ Frienduser:(NSString*)frienduser_ Type:(int)type_;

-(id)init;
-(NSString*)getId;
-(NSString*)getResourceKey;
-(NSString*)getUserId;
-(void)setData:(NSDictionary*)data;

-(void)load:(NSString*)id_ onComplete:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void) list:(NSString*)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void) list:(NSString*)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)setUser:(User*)obj;
-(void)saveWithCompletion:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void)deleteWithCompletion:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
@end
