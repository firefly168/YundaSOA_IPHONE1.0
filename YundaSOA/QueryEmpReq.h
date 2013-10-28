//
//  QueryEmpReq.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "RequestBean.h"
#import "PageBean.h"

@interface QueryEmpReq : RequestBean

@property NSString * keywords;
@property PageBean * bean;

@end
