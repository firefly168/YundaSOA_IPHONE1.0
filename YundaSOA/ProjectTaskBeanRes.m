//
//  ProjectTaskBeanRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ProjectTaskBeanRes.h"
#import "ProjectTaskInfoBean.h"

@implementation ProjectTaskBeanRes

+(Class) list_class {
    return [ProjectTaskInfoBean class];
}

@end
