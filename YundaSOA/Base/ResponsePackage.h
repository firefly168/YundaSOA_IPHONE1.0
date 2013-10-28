//
//  ResponsePackage.h
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResponseBean;

@interface ResponsePackage : NSObject

@property (getter = getReqID,setter = setReqID:) int reqID;
@property (getter = getParam,setter = setParam:) ResponseBean *param;
@property (getter = getResponseTime,setter = setResponseTime:) long responseTime;
@property (getter = getModule_id,setter = setModule_id:) NSString *module_id;

@end
