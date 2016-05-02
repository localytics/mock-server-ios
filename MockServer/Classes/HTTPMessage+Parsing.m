//
//  HTTPMessage+Parsing.m
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "HTTPMessage+Parsing.h"

@implementation HTTPMessage (LLParsing)

- (NSString *)ll_bodyString {
    NSData *body = [self body];
    return [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
}

- (id)ll_bodyJsonWithError:(NSError **)error {
    NSData *body = [self body];
    return [NSJSONSerialization JSONObjectWithData:body
                                           options:0
                                             error:error];
}

@end
