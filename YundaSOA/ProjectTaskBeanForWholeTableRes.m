//
//  ProjectTaskBeanForWholeTableRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ProjectTaskBeanForWholeTableRes.h"
#import "ProjectTaskInfoForWholeTableBean.h"

@implementation ProjectTaskBeanForWholeTableRes

+(Class) wholeTableBeans_class {
    return [ProjectTaskInfoForWholeTableBean class];
}

@end
