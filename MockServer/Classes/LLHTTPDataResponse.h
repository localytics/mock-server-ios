//
//  LLHTTPDataResponse.h
//  Localytics
//
//  Created by mpatey on 10/21/15.
//  Copyright © 2015 Localytics. All rights reserved.
//

#import "HTTPDataResponse.h"

@interface LLHTTPDataResponse : HTTPDataResponse

@property (nonatomic, assign) NSInteger statusCode;

- (instancetype)initWithData:(NSData *)data
                  statusCode:(NSInteger)statusCode;
- (instancetype)initWithJsonObject:(id)object
                        statusCode:(NSInteger)statusCode;

@end
