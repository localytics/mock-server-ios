//
//  LLMockServer.h
//  Localytics
//
//  Created by mpatey on 10/1/15.
//  Copyright © 2015 Localytics. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPMessage;
@protocol HTTPResponse;

@interface LLMockServer : NSObject

@property (nonatomic, readonly, assign) NSUInteger port;
@property (nonatomic, readonly) NSString *host;

- (BOOL)startServer;
- (HTTPMessage *)getNextRequest;

// Override to customize behavior
- (BOOL)supportsMethod:(NSString *)method
                atPath:(NSString *)path;
- (NSObject <HTTPResponse> *)httpResponseForMethod:(NSString *)method
                                               URI:(NSString *)path;

@end
