//
//  HTTPMessage+Parsing.h
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

#import "HTTPMessage.h"

@interface HTTPMessage (Parsing)

- (NSString *)bodyString;
- (id)bodyJsonWithError:(NSError **)error;

@end
