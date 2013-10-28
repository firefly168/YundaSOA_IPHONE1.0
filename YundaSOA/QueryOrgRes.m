//
//  QueryOrgRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "QueryOrgRes.h"
#import "OrgInfoBean.h"
#import "EmpInfoBean.h"

@implementation QueryOrgRes

+(Class) orgInfoBeans_class {
    return [OrgInfoBean class];
}

+(Class) empInfoBeans_class {
    return [EmpInfoBean class];
}

@end
