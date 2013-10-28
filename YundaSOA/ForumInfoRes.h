//
//  ForumInfoRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface ForumInfoRes : ResponseBean

@property NSArray * topics;
@property NSArray * stores;

+(Class) topics_class;
+(Class) stores_class;

@end
