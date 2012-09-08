//
//  SCHTTPRequestHandler.h
//  scarf-indev
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCHTTPRequest.h"
#import "SCHTTPResponse.h"

typedef BOOL (^SCHTTPRequestHandlerBlock)(SCHTTPRequest *, SCHTTPResponse *);

@interface SCHTTPRequestHandler : NSObject {
@private
    NSMutableDictionary *handlers;
}

- (id)init;
- (id)initWithHandlers:(NSDictionary *)handlerDict;

- (void)setHandlerBlock:(SCHTTPRequestHandlerBlock)handlerBlock forMethod:(NSString *)method;
- (void)setHandlerTarget:(id)target selector:(SEL)selector forMethod:(NSString *)method;
- (BOOL)handleRequest:(SCHTTPRequest *)request response:(SCHTTPResponse *)response;

@property(readonly, retain) NSDictionary *handlers;
@end
