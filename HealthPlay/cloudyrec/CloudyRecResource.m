//
//  CloudyRecResource.m
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import "CloudyRecResource.h"
#import "JSONKit.h"

@implementation CloudyRecResource
@synthesize appKey;
@synthesize conx;
@synthesize debug;
@synthesize _id;
@synthesize version;


-(id)init {
  if(self=[super init]) {
    self.appKey=@"1BMNnrXU6m";
    self.version=@"0";
  }
  return self;
}
-(NSString*) getAppKey {
  return self.appKey;
}

-(NSString*) getId {
  return self._id;
}

-(NSString*)getResourceKey {
  //ToDO: to be overwritten by Sub Class
  return nil;
}

#pragma mark - new method
-(void)listFromCloud:(NSString*)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  [self listFromCloud:query Limit:10 Page:1 onComplete:completion onFailure:fail];
}

-(void)listFromCloud:(NSString*)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
 
  if(limit < 0) {
    limit =10;
  }
  if(page < 1) {
    page= 1;
  }
  
  NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithCapacity:2];
  [data setValue:[NSNumber numberWithInt:limit] forKey:@"limit"];
  [data setValue:[NSNumber numberWithInt:page] forKey:@"page"];
  
  self.conx = nil;
  self.conx =[[[CloudyRecConnector alloc] init] autorelease];
  NSString* url;
  if(query==nil || [query isEqualToString:@""])
  {
    url=[NSString stringWithFormat:@"/%@/%@/%@",self.version,self.appKey,[self getResourceKey]];
  }
  else {
    [data setValue:query forKey:@"query"];
    url=[NSString stringWithFormat:@"/%@/%@/%@",self.version,self.appKey,[self getResourceKey]];
  }
  
  [self.conx httpGet:url Data:data onCompletion:^(SimpleHttpResponse* respond){
    NSError* error;
    [data release];
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      completion([respond.body objectFromJSONString]);
    }
  }onFailure:^(NSError* err){
    [data release];
    fail(err);
  }];
}

-(void)listChildren:(CloudyRecResource*)resourceClass filter:(NSString *)query onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
    [self listChildren:resourceClass filter:query Limit:10 Page:1 onComplete:completion onFailure:fail];
}

-(void)listChildren:(CloudyRecResource*) resourceClass onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  [self listChildren:resourceClass filter:nil Limit:10 Page:1 onComplete:completion onFailure:fail];
}

-(void)listChildren:(CloudyRecResource *)resourceClass filter:(NSString *)query Limit:(int)limit Page:(int)page onComplete:(cloudyRecRespondBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  
  if(limit < 0) {
    limit=10;
  }
  if(page < 1) {
    page=1;
  }
  
  NSMutableDictionary* data =[[NSMutableDictionary alloc] initWithCapacity:2];
  [data setValue:[NSNumber numberWithInt:limit] forKey:@"limit"];
  [data setValue:[NSNumber numberWithInt:page] forKey:@"page"];

  if (query != nil)
    [data setValue:query forKey:@"query"];
  
  //clear first for memory leak
  self.conx = nil;
  self.conx =[[[CloudyRecConnector alloc] init] autorelease];
  NSString* url =[NSString stringWithFormat:@"/%@/%@/%@/cof/%@",self.version,self.appKey,[resourceClass getResourceKey],self._id];
  
  [self.conx httpGet:url Data:data onCompletion:^(SimpleHttpResponse* respond) {
    NSError* error;
    [data release];
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
    completion([respond.body objectFromJSONString]);
    }
  }onFailure:^(NSError* err) {
    [data release];
    fail(err);
  }];
  
}

-(void)loadFromCloud:(NSString*)resourceID onComplete:(cloudyRecRespondDictBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  
  self.conx=nil;
  self.conx=[[[CloudyRecConnector alloc] init] autorelease];

  NSString* url=[NSString stringWithFormat:@"/%@/%@/%@/%@",self.version,self.appKey,[self getResourceKey],resourceID];
  
  [self.conx httpGet:url Data:nil onCompletion:^(SimpleHttpResponse* respond) {
    NSError* error;
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      completion([respond.body objectFromJSONString]);
    }
  }onFailure:^(NSError* err) {
    fail(err);
  }];
}

-(void) authenticateToCloud:(NSString*)uname Password:(NSString*)passwd onComplete:(cloudyRecRespondDictBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  
  self.conx=nil;
  self.conx=[[[CloudyRecConnector alloc] init] autorelease];

  NSMutableDictionary* data =[[NSMutableDictionary alloc] initWithCapacity:2];
  [data setValue:uname forKey:@"_uname"];
  [data setValue:passwd forKey:@"_passwd"];
  
  NSString* url =[NSString stringWithFormat:@"/%@/%@/%@/auth",self.version,self.appKey,[self getResourceKey]];
  [self.conx httpPost:url Data:data onCompletion:^(SimpleHttpResponse* respond){
    NSError* error;
    [data release];
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      completion([respond.body objectFromJSONString]);
    }
  }onFailure:^(NSError* err) {
        [data release];
    fail(err);
  }];
  
}

-(void) insertToCloud:(NSDictionary*)data onComplete:(cloudyRecRespondStirngBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  
  self.conx=nil;
  self.conx= [[[CloudyRecConnector alloc] init] autorelease];

  NSString* url =[NSString stringWithFormat:@"/%@/%@/%@",self.version,self.appKey,[self getResourceKey]];
  [self.conx httpPost:url Data:data onCompletion:^(SimpleHttpResponse* respond){
    NSError* error;
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      completion(respond.body);
    }
  }onFailure:^(NSError* err){
    fail(err);
  }];
}

-(void) updateToCloud:(NSDictionary*)data onComplete:(cloudyRecRespondStirngBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  self.conx=nil;
  self.conx=[[[CloudyRecConnector alloc] init] autorelease];
  
  NSString* url=[NSString stringWithFormat:@"/%@/%@/%@/%@",self.version,self.appKey,[self getResourceKey],self._id];
  [self.conx httpPut:url Data:data onCompletion:^(SimpleHttpResponse* respond) {
    NSError* error;
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      completion(respond.body);
    }
  }onFailure:^(NSError* err){
    fail(err);
  }];
}

-(void)deleteFromCloudWithonComplete:(cloudyRecRespondBoolBlock)completion onFailure:(cloudyRecRespondErrorBlock)fail {
  self.conx=nil;
  self.conx=[[[CloudyRecConnector alloc] init] autorelease];

  NSString* url=[NSString stringWithFormat:@"/%@/%@/%@/%@",self.version,self.appKey,[self getResourceKey],self._id];
  [self.conx httpDelete:url Data:nil onCompletion:^(SimpleHttpResponse* respond){
    NSError* error;
    [self checkAndRaiseError:respond Error:&error];
    
    if(error!=nil) {
      fail(error);
    }
    else {
      if(respond.status == 204)
      {
        completion(YES);
      }
      else {
        completion(NO);
      }
    }
  }onFailure:^(NSError* err) {
    fail(err);
  }];
}

#pragma mark - private Method

-(BOOL)checkAndRaiseError:(SimpleHttpResponse*) resp Error:(NSError**)Reqerror{
  NSDictionary* job;
  
  NSMutableDictionary* details = [NSMutableDictionary dictionary];

  if(resp.status >=401 && resp.status <=502) {
    
    job = [resp.body objectFromJSONString];
    
    NSString* errorMessage=[NSString stringWithFormat:@"Status %d , %@",resp.status,[job objectForKey:@"message"]];
      [details setValue:errorMessage forKey: NSLocalizedDescriptionKey];
    
     if (Reqerror!=nil){ 
        *Reqerror = [NSError errorWithDomain:@"cloudyRec" code:resp.status userInfo:details];
         return YES;
     }
     else {
         return NO;
     }
  }
  else {
      
      if (Reqerror!=nil)
          *Reqerror=nil;
      return NO;
  }

}

@end
