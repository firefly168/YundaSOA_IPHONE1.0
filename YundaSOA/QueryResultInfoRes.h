//
//  QueryResultInfoRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
@class PageBean;

@interface QueryResultInfoRes : ResponseBean

@property NSArray * projectList;
@property PageBean * bean;

+(Class) projectList_class;

@end
