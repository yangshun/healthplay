//
//  CloudyRecConnector.h
//  Generated by CloudyRec - mobile backend platform.
//  Copyright (c) 2012 Rival Edge Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleHttpResponse.h"

typedef void (^httpResponseBlock)(SimpleHttpResponse* respond);
typedef void (^httpErrorBlock)(NSError* respond);
@interface CloudyRecConnector : NSObject <NSURLConnectionDelegate> {
  @private
  NSString* scheme;
  NSString* host;
  int port;
  BOOL downloading;
}
@property(nonatomic,retain) NSString* scheme;
@property(nonatomic,retain) NSString* host;
@property(nonatomic,assign) int port;
@property(nonatomic,retain) SimpleHttpResponse* respond;

@property(nonatomic,retain) NSMutableArray* queue;
@property(nonatomic) BOOL downloading;

-(void)httpGet:(NSString*)url Data:(NSDictionary*)data onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;

-(void)httpDownload:(NSString*)url Data:(NSDictionary*)data onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;

-(void)httpPost:(NSString*)url Data:(NSDictionary*)data onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;

-(void)httpPut:(NSString*)url Data:(NSDictionary*)data onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;

-(void)httpDelete:(NSString*)url Data:(NSDictionary*)data onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;

//public SimpleHttpResponse httpPostMultipart(String url, byte[] data, String fileName, String contentType)
-(void)httpPostMultipartWithURL:(NSString*)url Data:(NSData*)data ContentType:(NSString*)contentType FileName:(NSString*)fileName onCompletion:(httpResponseBlock)completion onFailure:(httpErrorBlock)fail;
@end

