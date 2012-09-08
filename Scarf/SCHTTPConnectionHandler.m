//
//  SCHTTPConnectionHandler.m
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPConnectionHandler.h"
#import "SCHTTPRequestHandler.h"

#define SCHeaderTerminator "\r\n\r\n"
#define SCReadHeaderDataTag 1
#define SCReadBodyDataTag 2

@implementation SCHTTPConnectionHandler

- (id)initWithRoutes:(NSDictionary *)routeDict socket:(GCDAsyncSocket *)connectedSocket {
    self = [super init];
    if (self) {
        routes = routeDict;
        socket = connectedSocket;
        buffer = [[NSMutableData alloc] init];
        [socket setDelegate:self];
        [socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:120 tag:SCReadHeaderDataTag];
    }
    return self;
}

- (void)parseHeaders {
    NSString *bufferString = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
    NSArray *lines = [bufferString componentsSeparatedByString:@"\r\n"];
    
    NSArray *initialLine = [[lines objectAtIndex:0] componentsSeparatedByString:@" "];
    method = [initialLine objectAtIndex:0];
    path = [initialLine objectAtIndex:1];
    protocol = [initialLine objectAtIndex:2];
    
    NSMutableArray *headerKeys = [[NSMutableArray alloc] init];
    NSMutableArray *headerValues = [[NSMutableArray alloc] init];
    for (uint16_t i = 1; i < [lines count] - 2; ++i) {
        NSString *key = [[[lines objectAtIndex:i] componentsSeparatedByString:@": "] objectAtIndex:0];
        [headerKeys addObject:key];
        NSString *value = [[lines objectAtIndex:i] substringFromIndex:[key length] + 2];
        [headerValues addObject:value];
    }
    headers = [NSDictionary dictionaryWithObjects:headerValues forKeys:headerKeys];
    
    bufferString = nil;
    lines = nil;
    initialLine = nil;
    headerKeys = nil;
    headerValues = nil;
    [buffer setLength:0];
    

    NSUInteger contentLength = 0;
    for (NSString *key in [headers allKeys]) {
        if ([key compare:@"Content-Length" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            contentLength = [[headers objectForKey:key] integerValue];
        }
    }
    if (contentLength > 0) {
        [socket readDataToLength:contentLength withTimeout:(contentLength / 1024.0) buffer:buffer bufferOffset:0 tag:SCReadBodyDataTag];
    } else {
        SCHTTPRequest *request = [[SCHTTPRequest alloc] initWithMethod:method
                                                                  path:path
                                                              protocol:protocol
                                                               headers:headers
                                                                  body:nil];
        [self handleRequest:request];
    }
}

- (void)handleRequest:(SCHTTPRequest *)request {
    id routeHandler = routes[[request path]];
    SCHTTPResponse *response = [[SCHTTPResponse alloc] initWithSocket:socket];
    if ([routeHandler isKindOfClass:[SCHTTPRequestHandler class]]) {
        if ([routeHandler handleRequest:request response:response]) {
            [response finish];
        }
    } else {
        [response setStatusCode:404];
        [response setValue:@"text/plain" forHeader:@"Content-Type"];
        [response write:@"404 Not Found"];
        [response finish];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    // Sent data
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (tag == SCReadHeaderDataTag) {
        [buffer appendData:data];
        if (strstr([buffer bytes], SCHeaderTerminator)) {
            [self parseHeaders];
        } else {
            [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:120 tag:SCReadHeaderDataTag];
        }
    } else if (tag == SCReadBodyDataTag) {
        SCHTTPRequest *request = [[SCHTTPRequest alloc] initWithMethod:method
                                                                  path:path
                                                              protocol:protocol
                                                               headers:headers
                                                                  body:data];
        [self handleRequest:request];
    }
}

@end
