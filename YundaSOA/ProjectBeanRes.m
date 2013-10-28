//
//  ProjectBeanRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ProjectBeanRes.h"
#import "ProjectInfoBean.h"

@implementation ProjectBeanRes

+ (Class)projectList_class {
    return [ProjectInfoBean class];
}

@end
