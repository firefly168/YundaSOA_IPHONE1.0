//
//  ForumInfoRes.m
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ForumInfoRes.h"
#import "ForumPublishInfoBean.h"
#import "ForumAnswerInfoBean.h"

@implementation ForumInfoRes

+(Class) topics_class {
    return [ForumPublishInfoBean class];
}

+(Class) stores_class {
    return [ForumAnswerInfoBean class];
}

@end
