//
//  HttpCaller.h
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageCenter;

static int const REQUEST_ID_INVALID;

static NSString * const MODULE_ID_LOGIN = @"C001";
static NSString * const MODULE_ID_CALENDAR = @"C002";
static NSString * const MODULE_ID_QUERY_PROJECT = @"C003";
static NSString * const MODULE_ID_BASESET_QUERY_COUNT = @"C004";
static NSString * const MODULE_ID_BASESET_QUERY_CATEGORY = @"C004-1";
static NSString * const MODULE_ID_BASESET_QUERY_CAT_ORG_INFO = @"C004-2";
static NSString * const MODULE_ID_DEPT_QUERY_CATEGORY = @"C005";
static NSString * const MODULE_ID_DEPT_QUERY_CAT_ORG_INFO = @"C005-1";
static NSString * const MODULE_ID_SELF_COUNT = @"C006";
static NSString * const MODULE_ID_SELF_QUERY = @"C007";
static NSString * const MODULE_ID_SELF_LIST = @"C008";
static NSString * const MODULE_ID_FORUM_LIST = @"C009";
static NSString * const MODULE_ID_FORUM_CREATE = @"C010";
static NSString * const MODULE_ID_FORUM_ANSWER = @"C011";
static NSString * const MODULE_ID_QUERY_TASK = @"C012";
static NSString * const MODULE_ID_GET_DEPT_TABLE = @"C013";
static NSString * const MODULE_ID_QUERY_WHOLE_TABLE = @"C014";
static NSString * const MODULE_ID_QUERY_ORG = @"C015";
static NSString * const MODULE_ID_QUERY_EMP = @"C016";
static NSString * const MODULE_ID_QUERY_NOTICE = @"C017";
static NSString * const MODULE_ID_QUERY_AREA_CUST_PROGRESS_LIST = @"C018";
static NSString * const MODULE_ID_QUERY_AREA_CUST_LIST = @"C019";
static NSString * const MODULE_ID_QUERY_CUST_INFO = @"C020";
static NSString * const MODULE_ID_QUERY_BRANCH_INFO = @"C021";
static NSString * const MODULE_ID_QUERY_AREA_MONTH_COUNT = @"C022";
static NSString * const MODULE_ID_QUERY_LOGISTICS_LIST = @"C023";

@interface HttpCaller : NSObject {
    MessageCenter * msgCtrl;
    int reqID;
    NSDictionary *p_resBeans;
}

+ (HttpCaller *) getCaller;

- (int) call:(NSString *) module_id setObj:(id) obj;


@end
