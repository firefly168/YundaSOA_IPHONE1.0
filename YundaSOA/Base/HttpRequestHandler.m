//
//  HttpRequestHandler.m
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import "HttpRequestHandler.h"
#import "MessageCenter.h"
#import "RequestPackage.h"
#import "CommonUtil.h"
#import "RequestBean.h"
#import "ResponsePackage.h"
#import "HttpUtil.h"
#import "ResponseBean.h"
#import "MessageCenter.h"
#import "TriggerInfo.h"
#import "WindowControl.h"
#import "ConfigReader.h"

static NSString * const HTTP_METHOD = @"POST";

static NSString * const HTTP_CONTENT_TYPE_JSON = @"application/x-www-form-urlencoded;charset=utf-8";

static NSString * const HTTP_CONTENT_TYPE = @"Content-Type";

static NSString * const PARTNERID = @"yundasoa";

static NSString * const PASSWORD = @"dGdeeBVyAmVZsqxs";

@implementation HttpRequestHandler

- (id) init {
    //初始化操作队列
    threadPool = [[NSOperationQueue alloc] init];
    //在这里限定了该队列只同时运行一个线程
    [threadPool setMaxConcurrentOperationCount:1];
    
    msgCtrl = [MessageCenter sharedInstance];
    
    [msgCtrl registerReceiver:MESSAGE_ID_HTTP_REQ queue:threadPool usingBlock:^(NSNotification * msg) {
        [self handleMessage:msg];
    }];
    
    return self;
}

- (void) handleMessage:(NSNotification *)notification {
    
    ResponsePackage *rep = [[ResponsePackage alloc] init];
    id req = [notification object];
    @try {
        
        if (req == nil || ![req isKindOfClass:[RequestPackage class]]) {
            NSLog(@"%@", @"illegalException object in MessageQueue is not instance of RequestPackage");
            return;
        }
        if ([CommonUtil getLoginUser]) {
            [[req getParam] setUser:[CommonUtil getLoginUser]];
        }
        int reqID = [req getReqID];
        [rep setReqID:reqID];
        [rep setModule_id:[req getModule_id]];
        if (![req getParam]) {
            return;
        }
        NSDictionary *json;
        json = [HttpUtil objectToJson:[req getParam]];
        if (!json) {
            return;
        }
        NSError *error;
        NSString *sJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error] encoding:NSUTF8StringEncoding];
        NSString * request = [req getUrl];
        NSRange range = [request rangeOfString:@"/[a-z,A-Z]*\\." options:NSRegularExpressionSearch];
        range.length -= 2;
        range.location += 1;
        request = [request substringWithRange:range];
        sJson = [HttpUtil security:PARTNERID version:[CommonUtil getVersion] password:PASSWORD request:request data:sJson];
        NSLog(@"%@%@",@"send:" ,sJson);
        
        NSData *res = [self doRequset:[req getUrl] forJson:sJson];
        
        NSLog(@"%@%@", @"received:" ,[[NSString alloc] initWithData:res encoding:NSUTF8StringEncoding]);
        
        [rep setParam:[HttpUtil parseJson:res fromClass:[req getResBean]]];
        NSString *date = [NSString stringWithFormat:@"%f",[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]];
        [rep setResponseTime:[date longLongValue]];

    }
    @catch (NSException *exception) {
        ResponseBean *res = [[ResponseBean alloc] init];
        [res setSuccess:COM_NET_ERROR];
        [res setMessage:[exception reason]];
        [rep setParam:res];
    }
    @finally {
        TriggerInfo *info = [[TriggerInfo alloc] init];
        [info setTriggerID:TRIGGER_ID_RESPONSE];
        [info setObjParam:rep];
        [[WindowControl getInstance] sendTriggerToScreen:info];
    }
}	

- (NSData *) doRequset:(NSString *) url forJson:(NSString *) json {
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:HTTP_METHOD];
    int timeout = DEFAULT_HTTP_TIMEOUT;
    timeout = [[ConfigReader getConfig:CONFIG_KEY_HTTP_TIMEOUT] intValue];
    [req setTimeoutInterval:timeout];
    [req setValue:HTTP_CONTENT_TYPE_JSON forHTTPHeaderField:HTTP_CONTENT_TYPE];
    [req setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error;
    NSData * res = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:&error];
    if (error) {
        NSLog(@"Request Error!:%@",[error description]);
        @throw [NSException exceptionWithName:@"IOException" reason:[error description] userInfo:nil];
    }
    return res;
}

- (void) dealloc {
    if (msgCtrl) {
        [msgCtrl unregisterReceiver:MESSAGE_ID_HTTP_REQ];
    }
}

@end
