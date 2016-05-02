//
//  LLMockServer.m
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "LLMockServer.h"
#import "LLHTTPConnection.h"
#import "HTTPDataResponse.h"
#import "HTTPServer.h"
#import "HTTPMessage+Parsing.h"

@interface LLMockServer () <LLHTTPConnectionDelegate>

@property (nonatomic, strong) HTTPServer *server;
@property (nonatomic, strong, readonly) NSCondition *queueCondition;
@property (nonatomic, strong, readonly) NSMutableArray *queue;
@property (nonatomic, strong, readonly) NSArray *supportedMethods;

@end

static NSString *const  LOCALHOST = @"localhost";

@implementation LLMockServer

- (instancetype)init {
    if (self = [super init]) {
        _queue = [NSMutableArray array];
        _queueCondition = [NSCondition new];
        _server = [HTTPServer new];
        [LLHTTPConnection setDelegate:self
                            forServer:_server];
        [_server setConnectionClass:[LLHTTPConnection class]];
        [_server setInterface:LOCALHOST];
        _host = LOCALHOST;
        _supportedMethods = @[@"POST", @"PUT"];
    }
    return self;
}

- (BOOL)startServer {
    NSError *error = nil;
    BOOL success = [_server start:&error];
    if (!success) {
        NSLog(@"failed to start mock server with error: %@", error);
    }
    
    return success;
}

- (NSUInteger)port {
    return [self.server listeningPort];
}

- (HTTPMessage *)getNextRequest {
    [self.queueCondition lock];
    
    if (self.queue.count == 0) {
        [self.queueCondition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }
    
    HTTPMessage *nextItem = [self.queue firstObject];
    if (nextItem) {
        [self.queue removeObjectAtIndex:0];
    }
    
    [self.queueCondition unlock];
    return nextItem;
}

#pragma mark - MSHTTPConnectionDelegate

- (void)didReceiveRequest:(HTTPMessage *)request {
    [self.queueCondition lock];
    [self.queue addObject:request ? request : [NSNull null]]; // TODO: handle on the other end.
    [self.queueCondition signal];
    [self.queueCondition unlock];
}

- (BOOL)supportsMethod:(NSString *)method
                atPath:(NSString *)path {
    return YES;
}

- (NSObject <HTTPResponse> *)httpResponseForMethod:(NSString *)method
                                               URI:(NSString *)path {
    return [[HTTPDataResponse alloc] initWithData:nil];
}

@end
