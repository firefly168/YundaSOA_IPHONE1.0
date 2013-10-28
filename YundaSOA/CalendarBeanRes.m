//
//  CalendarBeanRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CalendarBeanRes.h"
#import "CalendarInfoBean.h"

@implementation CalendarBeanRes

+ (Class) monthdata_class {
    return [CalendarInfoBean class];
}

@end
