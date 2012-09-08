//
//  SCHTTPRequest.m
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPRequest.h"

@implementation SCHTTPRequest

@synthesize method, path, protocol, body;

- (id)initWithMethod:(NSString *)methodString
                path:(NSString *)pathString
            protocol:(NSString *)protocolString
             headers:(NSDictionary *)headerDict
                body:(NSData *)bodyData {
    self = [super init];
    if (self) {
        method = methodString;
        path = pathString;
        protocol = protocolString;
        headers = headerDict;
        body = bodyData;
    }
    return self;
}

- (id)valueForHeader:(NSString *)name {
    for (NSString *key in [headers allKeys]) {
        if ([key compare:name options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return [headers objectForKey:key];
        }
    }
    return nil;
}

@end
