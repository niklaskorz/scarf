//
//  SCHTTPServer.m
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPServer.h"

@implementation SCHTTPServer

@synthesize routes;

- (id)init {
    self = [self initWithRoutes:nil];
    return self;
}

- (id)initWithRoutes:(NSDictionary *)routeDict {
    self = [super init];
    if (self) {
        delegateQueue = dispatch_queue_create("de.niklaskorz.Scarf.delegateQueue", 0);
        socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:delegateQueue];
        routes = [routeDict copy];
        connections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)listenToPort:(uint16_t)port error:(NSError **)errorPtr {
    [socket acceptOnPort:port error:errorPtr];
}

- (void)listenToHost:(NSString *)host port:(uint16_t)port error:(NSError **)errorPtr {
    [socket acceptOnInterface:host port:port error:errorPtr];
}

#pragma mark -
#pragma mark Delgate Methods

- (void)socket:(GCDAsyncSocket *)sender didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    if (routes) {
        SCHTTPConnectionHandler *handler = [[SCHTTPConnectionHandler alloc] initWithRoutes:routes socket:newSocket];
        [connections addObject:handler];
    }
}

@end
