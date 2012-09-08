//
//  SCHTTPRequestHandler.m
//  scarf-indev
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPRequestHandler.h"

@implementation SCHTTPRequestHandler

- (id)init {
    self = [self initWithHandlers:nil];
    return self;
}

- (id)initWithHandlers:(NSDictionary *)handlerDict {
    self = [super init];
    if (self) {
        handlers = [[NSMutableDictionary alloc] init];
        if (handlerDict) {
            for (NSString *key in [handlerDict allKeys]) {
                handlers[[key lowercaseString]] = handlerDict[key];
            }
        }
    }
    return self;
}

- (void)setHandlerBlock:(SCHTTPRequestHandlerBlock)handlerBlock forMethod:(NSString *)method {
    handlers[[method lowercaseString]] = handlerBlock;
}

- (void)setHandlerTarget:(id)target selector:(SEL)selector forMethod:(NSString *)method {
    handlers[[method lowercaseString]] = [NSArray arrayWithObjects:target, [NSValue valueWithPointer:selector], nil];
}

- (BOOL)handleRequest:(SCHTTPRequest *)request response:(SCHTTPResponse *)response {
    id handler = handlers[[[request method] lowercaseString]];
    if ([handler isKindOfClass:NSClassFromString(@"NSBlock")]) {
        return ((SCHTTPRequestHandlerBlock) handler)(request, response);
    } else if ([handler isKindOfClass:[NSArray class]]) {
        id target = [handler objectAtIndex:0];
        SEL selector = [[handler objectAtIndex:1] pointerValue];
        return (BOOL)[target performSelector:selector withObject:request withObject:response];
    } else {
        [response setStatusCode:405];
        [response setValue:@"text/plain" forHeader:@"Content-Type"];
        [response write:@"405 Method Not Allowed"];        
        return YES;
    }
}

@end
