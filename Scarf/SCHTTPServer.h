//
//  SCHTTPServer.h
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import <dispatch/dispatch.h>
#import "SCHTTPConnectionHandler.h"

@interface SCHTTPServer : NSObject {
@private
    dispatch_queue_t delegateQueue;
    GCDAsyncSocket *socket;
    NSDictionary *routes;
    NSMutableArray *connections;
}

- (id)init;
- (id)initWithRoutes:(NSDictionary *)routeDict;
- (void)listenToPort:(uint16_t)port error:(NSError **)errorPtr;
- (void)listenToHost:(NSString *)host port:(uint16_t)port error:(NSError **)errorPtr;

// Delegate methods
- (void)socket:(GCDAsyncSocket *)sender didAcceptNewSocket:(GCDAsyncSocket *)newSocket;

// Properties
@property(copy) NSDictionary *routes;
@end
