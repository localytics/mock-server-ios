//
//  LLHTTPDataResponse.m
//  Localytics
//
//  Created by mpatey on 10/21/15.
//  Copyright © 2015 Localytics. All rights reserved.
//

#import "LLHTTPDataResponse.h"

@implementation LLHTTPDataResponse

// override
- (id)initWithData:(NSData *)responseData {
    return [self initWithData:responseData
                   statusCode:200];
}

- (instancetype)initWithData:(NSData *)dataParam
                  statusCode:(NSInteger)statusCode {
    if (self = [super initWithData:dataParam]) {
        _statusCode = statusCode;
    }
    return self;
}

- (instancetype)initWithJsonObject:(id)object
                        statusCode:(NSInteger)statusCode {
    NSError *error;
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:0
                                                             error:&error];
    if (error) {
        NSLog(@"failed to create json data for object %@", object);
        return nil;
    }

    return [self initWithData:responseData statusCode:statusCode];
}


- (NSInteger)status {
    return self.statusCode;
}

@end
