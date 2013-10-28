//
//  HttpUtil.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestBean;
@class ResponseBean;
@class NSDictionary;
@class NSData;

@interface HttpUtil : NSObject

+ (NSDictionary *) objectToJson:(RequestBean *) req;

+ (ResponseBean *) parseJson:(NSData *) res fromClass:(Class) clazz;

+ (NSString *) security:(NSString *) partnerid version:(NSString *) version password:(NSString *) password request:(NSString *) request data:(NSString *) data;

+ (NSString *) md5:(NSString *) source;
@end
