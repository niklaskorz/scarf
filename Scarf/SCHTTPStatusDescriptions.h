//
//  SCHTTPStatusDescriptions.h
//  scarf-indev
//
//  Created by Niklas Korz on 08.09.12.
//  Copyright (c) 2012 Niklas Korz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCHTTPStatusDescriptions : NSObject {
@private
    NSDictionary *statusDescriptions;
}

+ (SCHTTPStatusDescriptions *)sharedStatusDescriptions;
- (NSString *)descriptionForStatusCode:(uint16_t)statusCode;

@end
