//
//  ProjectTaskBeanReq.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "RequestBean.h"
@class ProjectTaskOfReqBean;
@class PageBean;

@interface ProjectTaskBeanReq : RequestBean

@property ProjectTaskOfReqBean * criteria;
@property PageBean * page;

@end
