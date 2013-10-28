//
//  TriggerInfo.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

static int const TRIGGER_ID_START = 0;
static int const TRIGGER_ID_TEST = TRIGGER_ID_START + 1;
static int const TRIGGER_ID_RESPONSE = TRIGGER_ID_TEST + 1;

@interface TriggerInfo : NSObject

@property (getter = getTriggerID, setter = setTriggerID:) int triggerID;
@property (getter = getParam1, setter = setParam1:) long param1;
@property (getter = getParam2, setter = setParam2:) long param2;
@property (getter = getParam3, setter = setParam3:) long param3;
@property (getter = getParam4, setter = setParam4:) long param4;
@property (getter = getSParam, setter = setSParam:) NSString *sParam;
@property (getter = getObjParam, setter = setObjParam:) id objParam;

@end
