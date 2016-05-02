//
//  LLHTTPConnection.h
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "HTTPConnection.h"

@protocol LLHTTPConnectionDelegate <NSObject>

- (void)didReceiveRequest:(HTTPMessage *)request;
- (BOOL)supportsMethod:(NSString *)method
                atPath:(NSString *)path;
- (NSObject <HTTPResponse> *)httpResponseForMethod:(NSString *)method
                                               URI:(NSString *)path;

@end

@interface LLHTTPConnection : HTTPConnection

+ (void)setDelegate:(id <LLHTTPConnectionDelegate>)delegate
          forServer:(HTTPServer *)server;
+ (void)clearDelegate:(id <LLHTTPConnectionDelegate>)delegate
          forServer:(HTTPServer *)server;

@end
