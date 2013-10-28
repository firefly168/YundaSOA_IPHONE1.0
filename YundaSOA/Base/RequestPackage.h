//
//  RequestPackage.h
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestBean;

@interface RequestPackage : NSObject

@property (getter = getUrl,setter = setUrl:) NSString *url;
@property (getter = getModule_id,setter = setModule_id:) NSString *module_id;
@property (getter = getResBean,setter = setResBean:) Class resBean;
@property (getter = getReqID,setter = setReqID:) int reqID;
@property (getter = getRequestTime,setter = setRequestTime:) long requestTime;
@property (getter = getParam,setter = setParam:) RequestBean *param;
@property (getter = getReceiver,setter = setReceiver:) NSString *receiver;

@end
