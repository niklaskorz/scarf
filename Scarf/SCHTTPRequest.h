//
//  SCHTTPRequest.h
//  Scarf
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCHTTPRequest : NSObject {
@private
    NSString *method, *path, *protocol;
    NSDictionary *headers;
    NSData *body;
}

- (id)initWithMethod:(NSString *)methodString
                path:(NSString *)pathString
            protocol:(NSString *)protocolString
             headers:(NSDictionary *)headerDict
                body:(NSData *)bodyData;

- (id)valueForHeader:(NSString *)name;

@property(readonly) NSString *method, *path, *protocol;
@property(readonly) NSData *body;

@end
