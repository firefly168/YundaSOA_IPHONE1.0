//
//  ProjectTaskBeanRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
@class PageBean;

@interface ProjectTaskBeanRes : ResponseBean

@property NSArray * list;
@property PageBean * page;

+(Class) list_class;

@end
