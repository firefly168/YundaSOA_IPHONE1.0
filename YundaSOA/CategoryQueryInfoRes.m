//
//  CategoryQueryInfoRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CategoryQueryInfoRes.h"
#import "ProjectInfoBean.h"

@implementation CategoryQueryInfoRes

+(Class) tasks_class {
    return [ProjectInfoBean class];
}

+(Class) zltasks_class {
    return [ProjectInfoBean class];
}

@end
