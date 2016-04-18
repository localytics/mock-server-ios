//
//  HTTPMessage+Parsing.m
//  Copyright (C) 2016 Char Software Inc., DBA Localytics
//
//  This code is provided under the Localytics Modified BSD License.
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "HTTPMessage+Parsing.h"

@implementation HTTPMessage (Parsing)

- (NSString *)bodyString {
    NSData *body = [self body];
    return [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
}

- (id)bodyJsonWithError:(NSError **)error {
    NSData *body = [self body];
    return [NSJSONSerialization JSONObjectWithData:body
                                           options:0
                                             error:error];
}

@end
