//
//  Badge.h
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudyRecResource.h"
#import "User.h"
@interface Badge : CloudyRecResource
{
  @private
  NSString* badgeResKey;
  NSString* _master_id;
  NSString* name;
  int badgeid;
  int type;
  NSDate* time;

}

@property(nonatomic,retain) NSString *badgeResKey;
@property(nonatomic,retain) NSString *_master_id;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,assign) int badgeid;
@property(nonatomic,assign) int type;
@property(nonatomic,retain) NSDate *time;


-(id)initWithBadgeName:(NSString*)name_ Badgeid:(int)badgeid_ Type:(int)type_ Time:(NSDate*)time_;

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
