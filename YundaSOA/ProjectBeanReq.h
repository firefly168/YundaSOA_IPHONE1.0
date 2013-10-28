//
//  ProjectBeanReq.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "RequestBean.h"
@class ProjectQueryInfoBean;
@class PageBean;

@interface ProjectBeanReq : RequestBean

@property ProjectQueryInfoBean * criteria;
@property PageBean * page;

@end
