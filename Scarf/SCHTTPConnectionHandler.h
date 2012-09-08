//
//  SCHTTPConnectionHandler.h
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "SCHTTPRequest.h"
#import "SCHTTPResponse.h"

@interface SCHTTPConnectionHandler : NSObject {
@private
    NSDictionary *routes;
    GCDAsyncSocket *socket;
    NSMutableData *buffer;
    
    NSString *method, *path, *protocol;
    NSDictionary *headers;
    NSData *body;
}

- (id)initWithRoutes:(NSDictionary *)routeDict socket:(GCDAsyncSocket *)socket;
- (void)parseHeaders;
- (void)handleRequest:(SCHTTPRequest *)request;

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
@end
