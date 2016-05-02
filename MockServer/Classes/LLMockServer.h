//
//  LLMockServer.h
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import <Foundation/Foundation.h>

@class HTTPMessage;
@protocol HTTPResponse;

@interface LLMockServer : NSObject

@property (nonatomic, readonly, assign) NSUInteger port;
@property (nonatomic, readonly) NSString *host;
@property (nonatomic, readonly) NSString *authority;

- (BOOL)startServer;
- (HTTPMessage *)getNextRequest;

// Override to customize behavior
- (BOOL)supportsMethod:(NSString *)method
                atPath:(NSString *)path;
- (NSObject <HTTPResponse> *)httpResponseForMethod:(NSString *)method
                                               URI:(NSString *)path;

@end
