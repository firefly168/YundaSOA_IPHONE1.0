//
//  OrgInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "Jastor.h"

@interface OrgInfoBean : Jastor

@property int orgid;
@property NSString * orgcode;
@property NSString * orgname;
@property int orglevel;
@property NSString * orgdegree;
@property int  parentorgid;
@property NSString * orgseq;
@property NSString * orgtype;
@property NSString * orgaddr;
@property NSString * zipcode;
@property NSString * linkman;
@property NSString * linktel;
@property NSString * email;
@property NSString * weburl;
@property NSNumber * startdate;
@property NSNumber * enddate;
@property NSString * status;
@property NSString * area;
@property NSNumber * createtime;
@property NSNumber * sortno;
@property NSString * remark;
@property int belongtransid;
@property NSString * belongtranscode;
@property NSString * belongtransname;
@property NSNumber * lastupdatetime;
@property NSString * querybegin;
@property NSString * queryend;
@property NSArray * empInfoBeans;

+(Class) empInfoBeans_class;

@end
