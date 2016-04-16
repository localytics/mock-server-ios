//
//  HTTPMessage+Parsing.m
//  Localytics
//
//  Created by mpatey on 10/8/15.
//  Copyright © 2015 Localytics. All rights reserved.
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
