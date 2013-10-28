//
//  OrgInfoBean.m
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "OrgInfoBean.h"
#import "EmpInfoBean.h"

@implementation OrgInfoBean

+(Class) empInfoBeans_class {
    return [EmpInfoBean class];
}

@end
