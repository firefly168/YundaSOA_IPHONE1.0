//
//  QueryEmpRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
#import "PageBean.h"

@interface QueryEmpRes : ResponseBean

@property NSArray * list;
@property PageBean * bean;

+(Class) list_class;

@end
