//
//  LLHTTPDataResponse.h
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "HTTPDataResponse.h"

@interface LLHTTPDataResponse : HTTPDataResponse

@property (nonatomic, assign) NSInteger statusCode;

- (instancetype)initWithData:(NSData *)data
                  statusCode:(NSInteger)statusCode;
- (instancetype)initWithJsonObject:(id)object
                        statusCode:(NSInteger)statusCode;

@end
