//
//  ProjectBeanRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
@class PageBean;

@interface ProjectBeanRes : ResponseBean

@property NSArray * projectList;
@property PageBean * page;

+(Class) projectList_class;

@end
