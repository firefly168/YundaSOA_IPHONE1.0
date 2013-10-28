//
//  CommonUtil.h
//  YundaSOA
//
//  Created by rangex on 13-7-1.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponsePackage.h"

#define STOP_TIMER 1

@class UserInfoBean;
@class ResponseBean;

static NSString * const COM_SUCCESS = @"0";
static NSString * const COM_FAILED = @"1";
static NSString * const COM_EXCEPTION = @"-1";
static NSString * const COM_NET_ERROR = @"2";

static int const MODULE_INDEX_CALENDAR = -1;
static int const MODULE_INDEX_SEARCH = 0;
static int const MODULE_INDEX_BASESET = 1;
static int const MODULE_INDEX_DEPT = 2;
static int const MODULE_INDEX_SELF = 3;
static int const MODULE_INDEX_CREATE = 4;
static NSString * mVersion;

@interface CommonUtil : NSObject

+(UserInfoBean *) getLoginUser;
+(void) setLoginUser:(UserInfoBean *) user;
+(int) getCurrentModuleIndex;
+(void) setCurrentModuleIndex:(int) module;
+(ResponseBean *) checkResBean:(id) obj reqID:(int) reqID moduleID:(NSString *) moduleID;
+(ResponseBean *) checkResBean:(id) obj reqID:(int) reqID moduleID:(NSString *) moduleID delegate:(UIViewController *) delegate message:(NSString *) msg;
+(void) setAutoLogin:(BOOL) autologin password:(NSString *) pwd;
+(void) setVersion:(NSString *) version;
+(NSString *) getVersion;
+(NSString *) encodeBase64:(NSString *) src;

@end
