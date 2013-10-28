//
//  HttpCaller.m
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import "HttpCaller.h"
#import "MessageCenter.h"
#import "RequestPackage.h"
#import "ComConfigReader.h"
#import "ConfigReader.h"

@implementation HttpCaller

static HttpCaller* caller;

- (id) init{
    msgCtrl = [MessageCenter sharedInstance];
    reqID = REQUEST_ID_INVALID;
    
    NSString * pResBeansPath = [[NSBundle mainBundle] pathForResource:@"Res_Bean_Mapper" ofType:@"plist"];
    p_resBeans = [[NSDictionary alloc] initWithContentsOfFile:pResBeansPath];
    
    return self;
}

+ (HttpCaller *) getCaller {
    @synchronized(self) {
        if (!caller) {
            caller = [[self alloc] init];
        }
    }
    return caller;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (!caller) {
            caller = [super allocWithZone:zone];
            return caller;
        }
    }
    return nil;
}

- (int) call:(NSString *)module_id setObj:(id)obj{
    
    NSString *url = [self getUrl:module_id];
    
    if (![self vaild:url setModule_ID:module_id setParam:obj]) {
        return REQUEST_ID_INVALID;
    }
    
    if (reqID >= UINT_MAX) {
        reqID = REQUEST_ID_INVALID;
    }
    
    reqID++;
    
    BOOL pushed = NO;
    
    RequestPackage * req = [[RequestPackage alloc] init];
    NSString * clazz = [p_resBeans objectForKey:module_id];
    [req setReqID:reqID];
    [req setUrl:url];
    [req setModule_id:module_id];
    [req setResBean:NSClassFromString(clazz)];
    [req setParam:obj];
    NSString *date = [NSString stringWithFormat:@"%f",[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]];
    [req setRequestTime:[date longLongValue]];
    
    pushed = [msgCtrl sendMessage:MESSAGE_ID_HTTP_REQ setObj:req postingStyle:NSPostASAP];
    
    if (!pushed) {
        reqID--;
        return REQUEST_ID_INVALID;
    }
    
    return reqID;
}

- (NSString *) getUrl:(NSString *) module_id {
    NSString *url = [ConfigReader getConfig:CONFIG_KEY_HTTP_SERVER_URL];
    url = [url stringByAppendingString:[ComConfigReader getModuleURL:module_id]];
    return url;
}

- (BOOL) vaild:(NSString *) url setModule_ID:(NSString *) module_id setParam:(NSObject *) param {
    if (!url || [url isEqualToString:@""]) {
        NSLog(@"%@", @"Url parse error");
        return NO;
    }
    
    if (!module_id || [module_id isEqualToString:@""]) {
        NSLog(@"%@", @"module id is nil");
        return NO;
    }
    
    if (!param) {
        NSLog(@"%@", @"params is nil");
        return NO;
    }
    
    return YES;
}

@end
