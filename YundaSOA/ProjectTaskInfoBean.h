//
//  ProjectTaskInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface ProjectTaskInfoBean : Jastor

@property long prtid;
@property NSString * prtcode;
@property long prid;
@property long parentprtid;
@property long dId;
@property long createTime;
@property long openTime;
@property long creater;
@property long dealer;
@property long dealdeptid;
@property NSString * dealdesc;
@property NSString * prtdegree;
@property NSString * prtkeys;
@property long exTime;
@property NSString * taskStatus;
@property long realTime;
@property NSString * fileId;
@property float percentage;
@property int prtleavel;
@property NSString * isEmployee;
@property NSString * havaChild;
@property NSString * isDelete;
@property long updater;
@property long updateTime;
@property long deleter;
@property long deleteTime;
@property NSString * prop1;
@property NSString * prop2;
@property NSString * prop3;
@property NSString * prop4;
@property NSString * prop5;
@property NSString * createrName;
@property NSString * dealerName;
@property int deptIndex;
@property NSString * evaValue;
@property NSString * evaContent;

@end
