//
//  HTTPMessage+Parsing.h
//  Localytics
//
//  Created by mpatey on 10/8/15.
//  Copyright © 2015 Localytics. All rights reserved.
//

#import "HTTPMessage.h"

@interface HTTPMessage (Parsing)

- (NSString *)bodyString;
- (id)bodyJsonWithError:(NSError **)error;

@end
