//
//  SCHTTPStatusDescriptions.m
//  scarf-indev
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import "SCHTTPStatusDescriptions.h"

static SCHTTPStatusDescriptions *sharedStatusDescriptions = nil;

@implementation SCHTTPStatusDescriptions

+ (SCHTTPStatusDescriptions *)sharedStatusDescriptions {
    if (!sharedStatusDescriptions) {
        sharedStatusDescriptions = [[SCHTTPStatusDescriptions alloc] init];
    }
    return sharedStatusDescriptions;
}

- (id)init {
    self = [super init];
    if (self) {
        statusDescriptions = @{
            // 1xx
            @100: @"Continue",
            @101: @"Switching Protocols",
            @102: @"Processing",
            @118: @"Connection timed out",
            // 2xx
            @200: @"OK",
            @201: @"Created",
            @202: @"Accepted",
            @203: @"Non-Authorative Information",
            @204: @"No Content",
            @205: @"Reset Content",
            @206: @"Partial Content",
            @207: @"Multi-Status",
            // 3xx
            @300: @"Multiple Choices",
            @301: @"Moved Permanently",
            @302: @"Found",
            @303: @"See Other",
            @304: @"Not Modified",
            @305: @"Use Proxy",
            @306: @"",
            @307: @"Temporary Redirect",
            // 4xx
            @400: @"Bad Request",
            @401: @"Unauthorized",
            @402: @"Payment Required",
            @403: @"Forbidden",
            @404: @"Not Found",
            @405: @"Method Not Allowed",
            @406: @"Not Acceptable",
            @407: @"Proxy Authentication Required",
            @408: @"Request Time-out",
            @409: @"Conflict",
            @410: @"Gone",
            @411: @"Length Required",
            @412: @"Precondition Failed",
            @413: @"Request Entity Too Large",
            @414: @"Request-URL Too Long",
            @415: @"Unsupported Media Type",
            @416: @"Requested range not satisfiable",
            @417: @"Expectation Failed",
            @418: @"I'm a teapot",
            @421: @"There are too many connections from your internet address",
            @422: @"Unprocessable Entity",
            @423: @"Locked",
            @424: @"Failed Dependency",
            @425: @"Unordered Collection",
            @426: @"Upgrade Required",
            @451: @"Unavailable For Legal Reasons",
            // 5xx
            @500: @"Internal Server Error",
            @501: @"Not Implemented",
            @502: @"Bad Gateway",
            @503: @"Service Unavailable",
            @504: @"Gateway Time-out",
            @505: @"HTTP Version not supported",
            @506: @"Variant Also Negotiates",
            @507: @"Insufficient Storage",
            @509: @"Bandwidth Limit Exceeded",
            @510: @"Not Extended"
        };
    }
    return self;
}

- (NSString *)descriptionForStatusCode:(uint16_t)statusCode {
    return statusDescriptions[@(statusCode)];
}

@end
