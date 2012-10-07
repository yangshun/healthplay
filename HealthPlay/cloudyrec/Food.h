//
//  Food.h
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudyRecResource.h"
@interface Food : CloudyRecResource
{
  @private
  NSString* foodResKey;
  NSString* name;
  NSString* grade;
  NSDate* time;
  NSString* imageurl;

}

@property(nonatomic,retain) NSString *foodResKey;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *grade;
@property(nonatomic,retain) NSDate *time;
@property(nonatomic,retain) NSString *imageurl;


-(id)initWithFoodName:(NSString*)name_ Grade:(NSString*)grade_ Time:(NSDate*)time_ Imageurl:(NSString*)imageurl_;

-(id)init;
-(NSString*)getId;
-(NSString*)getResourceKey;
-(void)setData:(NSDictionary*)data;

-(void)load:(NSString*)id_ onComplete:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void) list:(NSString*)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void) list:(NSString*)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)saveWithCompletion:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void)deleteWithCompletion:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
@end
