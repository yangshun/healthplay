//
//  CloudyRecResource.h
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudyRecConnector.h"

typedef void (^cloudyRecRespondBlock)(NSArray* respond);
typedef void (^cloudyRecRespondDictBlock)(NSDictionary* respond);
typedef void (^cloudyRecRespondErrorBlock)(NSError* respond);
typedef void (^cloudyRecRespondStirngBlock)(NSString* respond);
typedef void (^cloudyRecRespondBoolBlock)(BOOL respond);
typedef void (^cloudyRecRespondDataBlock)(NSData* respond);

@interface CloudyRecResource : NSObject {
  @private
  NSString* appKey;
  NSString* version;
  CloudyRecConnector* conx;
  BOOL debug;
  
  @protected
  NSString* _id;
}
@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) CloudyRecConnector *conx;
@property (nonatomic, assign, getter=isDebug) BOOL debug;
@property (nonatomic, retain) NSString *_id;
-(NSString*) getAppKey;
-(NSString*) getId;
-(NSString*)getResourceKey;

-(void)listFromCloud:(NSString*)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)listFromCloud:(NSString*)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)listChildren:(CloudyRecResource*)resourceClass filter:(NSString *)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)listChildren:(CloudyRecResource*) resourceClass onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)listChildren:(CloudyRecResource *)resourceClass filter:(NSString *)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void)loadFromCloud:(NSString*)_id onComplete:(cloudyRecRespondDictBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void) authenticateToCloud:(NSString*)uname Password:(NSString*)passwd onComplete:(cloudyRecRespondDictBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(void) insertToCloud:(NSDictionary*)data onComplete:(cloudyRecRespondStirngBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void) updateToCloud:(NSDictionary*)data onComplete:(cloudyRecRespondStirngBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;
-(void)deleteFromCloudWithonComplete:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail;

-(BOOL)checkAndRaiseError:(SimpleHttpResponse*) resp Error:(NSError**)error;
@end
