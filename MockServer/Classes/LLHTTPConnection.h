//
//  LLHTTPConnection.h
//  Localytics
//
//  Created by mpatey on 10/1/15.
//  Copyright © 2015 Localytics. All rights reserved.
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
