//
//  LLHTTPConnection.m
//  Localytics
//
//  Created by mpatey on 10/1/15.
//  Copyright © 2015 Localytics. All rights reserved.
//

#import "LLHTTPConnection.h"
#import "HTTPMessage.h"

@interface LLHTTPConnection ()

@property (nonatomic, strong) NSMutableData *buffer;
@property (nonatomic, weak) id<LLHTTPConnectionDelegate> delegate;

@end

@implementation LLHTTPConnection

static NSMutableDictionary *serverDelegateMap;
static NSLock *mapLock;

+ (void)initialize {
    if ([self class] == [LLHTTPConnection class]) {
        serverDelegateMap = [NSMutableDictionary dictionary];
        mapLock = [NSLock new];
    }
}

+ (void)setDelegate:(id <LLHTTPConnectionDelegate>)delegate
          forServer:(HTTPServer *)server {
    [mapLock lock];
    NSValue *val = [NSValue valueWithNonretainedObject:server];
    serverDelegateMap[val] = delegate;
    [mapLock unlock];
}

+ (void)clearDelegate:(id <LLHTTPConnectionDelegate>)delegate
            forServer:(HTTPServer *)server {
    [mapLock lock];
    NSValue *val = [NSValue valueWithNonretainedObject:server];
    [serverDelegateMap removeObjectForKey:val];
    [mapLock unlock];
}

- (instancetype)initWithAsyncSocket:(GCDAsyncSocket *)newSocket
                      configuration:(HTTPConfig *)aConfig {
    if (self = [super initWithAsyncSocket:newSocket
                            configuration:aConfig]) {
        NSValue *val = [NSValue valueWithNonretainedObject:aConfig.server];
        [mapLock lock];
        _delegate = serverDelegateMap[val];
        [mapLock unlock];
    }
    return self;
}

- (void)processBodyData:(NSData *)postDataChunk {
    // the body is the only thing not automatically appended to the request object
    [self->request appendData:postDataChunk];
}

- (void)finishResponse {
    [self.delegate didReceiveRequest:self->request];
    [super finishResponse];
}

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path {
    return [self.delegate supportsMethod:method
                                  atPath:path]
            || [super supportsMethod:method
                              atPath:path];
}

- (NSObject <HTTPResponse> *)httpResponseForMethod:(NSString *)method
                                               URI:(NSString *)path {
    NSObject <HTTPResponse> *delegateResponse = [self.delegate httpResponseForMethod:method
                                                                                 URI:path];
    return delegateResponse ? delegateResponse : [super httpResponseForMethod:method
                                                                          URI:path];
}


@end
