//
//  SCHTTPResponse.h
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "SCHTTPStatusDescriptions.h"

@interface SCHTTPResponse : NSObject {
@private
    NSMutableDictionary *headers;
    NSMutableData *body;
    GCDAsyncSocket *socket;
    uint16_t statusCode;
    NSString *statusDescription;
}

- (id)initWithSocket:(GCDAsyncSocket *)connectedSocket;

- (id)valueForHeader:(NSString *)name;
- (void)setValue:(id)value forHeader:(NSString *)name;

- (void)write:(NSString *)string;
- (void)finish;

@property(readonly, retain) NSData *body;
@property(readwrite) uint16_t statusCode;
@property(copy) NSString *statusDescription;

@end
