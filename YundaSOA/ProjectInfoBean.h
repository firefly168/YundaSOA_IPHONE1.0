//
//  ProjectInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface ProjectInfoBean : Jastor

@property long prId;
@property NSString * prCode;
@property NSString * prsName;
@property NSString * prName;
@property NSString * isStr;
@property long prFq;
@property NSString * prFqName;
@property long prFz;
@property NSString * prFzName;
@property long prCr;
@property long long prCreateTime;
@property NSString * prDesc;
@property long long prStartTime;
@property long long prEndTime;
@property float prTime;
@property NSString * prStatus;
@property int prDeptId;
@property NSString * prPercentage;
@property NSString * prdegree;
@property NSString * prTemplate;
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

@end
