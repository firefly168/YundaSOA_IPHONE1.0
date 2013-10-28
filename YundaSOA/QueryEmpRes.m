//
//  QueryEmpRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "QueryEmpRes.h"
#import "EmpInfoBean.h"

@implementation QueryEmpRes

+(Class) list_class {
    return [EmpInfoBean class];
}

@end
