//
//  SCHTTPResponse.m
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPResponse.h"

@implementation SCHTTPResponse

@synthesize body;

- (id)initWithSocket:(GCDAsyncSocket *)connectedSocket {
    self = [super init];
    if (self) {
        socket = connectedSocket;
        headers = [[NSMutableDictionary alloc] init];
        body = [[NSMutableData alloc] init];
        statusCode = 200;
        statusDescription = nil;
    }
    return self;
}

- (id)valueForHeader:(NSString *)name {
    for (NSString *key in [headers allKeys]) {
        if ([key compare:name options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return headers[key];
        }
    }
    return nil;
}

- (void)setValue:(id)value forHeader:(NSString *)name {
    for (NSString *key in [headers allKeys]) {
        if ([key compare:name options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            headers[key] = value;
            return;
        }
    }
    headers[name] = value;
}

- (void)write:(NSString *)string {
    [body appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)finish {
    NSMutableString *headerString = [[NSMutableString alloc] init];
    SCHTTPStatusDescriptions *statusDescriptions = [SCHTTPStatusDescriptions sharedStatusDescriptions];
    if (!statusDescription)
        statusDescription = [statusDescriptions descriptionForStatusCode:statusCode];
    if (!statusDescription)
        statusDescription = @"No status description defined";
    [headerString appendFormat:@"HTTP/1.1 %hu %@\r\n", statusCode, statusDescription];
    for (NSString *key in [headers allKeys]) {
        id value = [headers objectForKey:key];
        [headerString appendFormat:@"%@: %@\r\n", key, value];
    }
    [headerString appendFormat:@"Content-Length: %lu\r\n", [body length]];
    [headerString appendString:@"\r\n"];
    NSData *headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *responseData = [[NSMutableData alloc] initWithCapacity:[headerData length] + [body length]];
    [responseData appendData:headerData];
    [responseData appendData:body];
    
    [socket writeData:responseData withTimeout:([responseData length] / 1024.0) tag:0];
    [socket disconnectAfterWriting];
}

@end
