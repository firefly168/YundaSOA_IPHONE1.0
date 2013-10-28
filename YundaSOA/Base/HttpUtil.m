//
//  HttpUtil.m
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "HttpUtil.h"
#import "RequestBean.h"
#import <objc/runtime.h>
#import "UserBeanRes.h"
#import "Jastor.h"
#import "JastorRuntimeHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "CommonUtil.h"

@class NSJSONSerialization;
@class NSDictionary;

@implementation HttpUtil

+ (NSDictionary *) objectToJson:(RequestBean *)req {
    
    return [self objectToDict:req];
}

+ (NSDictionary *) objectToDict: (id) obj {
    
    Class clazz  = [obj class];
//    u_int count;
    
    NSArray * props = [JastorRuntimeHelper propertyNames:clazz];
    
//    objc_property_t *props = class_copyPropertyList(clazz, &count);
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:[props count]];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:[props count]];
    
    for (int i = 0; i < [props count]; i++) {
//        objc_property_t prop = props[i];
        
//        const char * name = property_getName(prop);
        NSString *name = props[i];
//        [keys addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        [keys addObject:name];
        @try {

//            NSString * fieldName = [NSString stringWithUTF8String:name];
            
            NSString * fieldName = name;
            
//            NSString * fn_1 = [fieldName substringToIndex:1];
//            NSString * fn_2 = @"";
//            if ([fieldName length] > 1) {
//                fn_2= [fieldName substringFromIndex:1];
//            }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            id value = [obj performSelector:NSSelectorFromString(fieldName)];
#pragma clang diagnostic pop
            if (!value) {
                [keys removeObject:[keys lastObject]];
            } else {
                if ([self isJSONTYPE:value]) {
                    if ([value isKindOfClass:[NSMutableArray class]]) {
                        NSMutableArray *array = (NSMutableArray *)value;
                        [self checkArrayForJson:array];
                    }
                    [values addObject:value];
                } else {
                    [values addObject:[self objectToDict:value]];
                }
            }

        }
        @catch (NSException *exception) {
            continue;
        }
        @finally {
            
        }
        
    }
    return [[NSDictionary alloc] initWithObjects:values forKeys:keys];
}

+ (BOOL) checkArrayForJson:(NSMutableArray *) array {

    BOOL modified  =NO;
    
    for (int i = 0; i < [array count]; i++) {
        if ([self isJSONTYPE:[array objectAtIndex:i]]) {
            if ([[array objectAtIndex:i] isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *subArray = (NSMutableArray *) [array objectAtIndex:i];
                BOOL subModified = [self checkArrayForJson:subArray];
                if (subModified) {
                    [array setObject:subArray atIndexedSubscript:i];
                    modified = YES;
                }
            }
            continue;
        } else {
            [array setObject:[self objectToDict:[array objectAtIndex:i]] atIndexedSubscript:i];
            modified = YES;
        }
    }
    return modified;
}

+ (ResponseBean *) parseJson:(NSData *)res fromClass:(Class)clazz {
    if (!res) {
        return nil;
    }

//    ResponseBean *r = [[UserBeanRes alloc] init];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:kNilOptions error:&error];
//    [self dictToObject:dict withObj:r];
    
    ResponseBean *r = [[clazz alloc] initWithDictionary:dict];
    
    return r;
}

+ (void) dictToObject:(NSDictionary *) dict withObj:(ResponseBean *) obj {

    if (!dict || !obj) {
        return;
    }
    
    [self _fillObjectByDict:dict withObject:obj];
    
}

+ (void) _fillObjectByDict:(NSDictionary *) dict withObject:(ResponseBean *) obj {

    Class clazz  = [obj class];

    NSArray *keys = [dict allKeys];
    
    for (int i = 0; i < [keys count]; i++) {
        NSString *name = keys[i];
        objc_property_t prop = class_getProperty(clazz, [name cStringUsingEncoding:NSUTF8StringEncoding]);
        id value = [dict objectForKey:name];

        @try {
        
            NSString * fieldName = name;
            NSString * fn_1 = [fieldName substringToIndex:1];
            NSString * fn_2 = @"";
            if ([fieldName length] > 1) {
                fn_2= [fieldName substringFromIndex:1];
            }
            if (value) {
                if ([value isKindOfClass:[NSDictionary class]]) {
                    const char * attr = property_copyAttributeValue(prop, "T");
                    if (!attr) {
                        continue;
                    }
                    if (attr[0] != '@') {
                        continue;
                    }
                    if (strlen(attr) >= 3) {
                        char *className = strndup(attr + 2, strlen(attr) - 3);
                        Class clazz = NSClassFromString([NSString stringWithUTF8String:className]);
                        id subObj = [[clazz alloc] init];
                        [self _fillObjectByDict:value withObject:subObj];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                        [obj performSelector:NSSelectorFromString([[@"set" stringByAppendingString:[[fn_1 uppercaseString] stringByAppendingString:fn_2]] stringByAppendingString:@":"]) withObject:subObj];
#pragma clang diagnostic pop
                    }
                } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [obj performSelector:NSSelectorFromString([[@"set" stringByAppendingString:[[fn_1 uppercaseString] stringByAppendingString:fn_2]] stringByAppendingString:@":"]) withObject:value];
#pragma clang diagnostic pop
                }
            }
        
        }
        @catch (NSException *exception) {
            NSLog(@"exception! %@",[exception description]);
            continue;
        }
        @finally {
        }
    }

}

+ (BOOL) isJSONTYPE: (id) obj {

    return ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSNull class]]);
}

+ (NSString *) security:(NSString *)partnerid version:(NSString *)version password:(NSString *)password request:(NSString *)request data:(NSString *)data {

    data = [CommonUtil encodeBase64:data];
    
    NSString * validation = [self md5:[[data stringByAppendingString:partnerid] stringByAppendingString:password]];
    partnerid = [partnerid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    data = [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    validation = [validation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    partnerid = [[NSString alloc] initWithUTF8String:[partnerid cStringUsingEncoding:NSUnicodeStringEncoding]];
//    data = [[NSString alloc] initWithUTF8String:[data cStringUsingEncoding:NSUnicodeStringEncoding]];
//    validation = [[NSString alloc] initWithUTF8String:[validation cStringUsingEncoding:NSUnicodeStringEncoding]];
    
    return [[[[[[[[[[[@"partnerid=" stringByAppendingString:partnerid] stringByAppendingString:@"&version="] stringByAppendingString:version] stringByAppendingString:@"&data="] stringByAppendingString:data] stringByAppendingString:@"&password="] stringByAppendingString:password] stringByAppendingString:@"&request="] stringByAppendingString:request] stringByAppendingString:@"&validation="] stringByAppendingString:validation];
}

+ (NSString *) md5:(NSString *)source {

    const char *cStr = [source UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
