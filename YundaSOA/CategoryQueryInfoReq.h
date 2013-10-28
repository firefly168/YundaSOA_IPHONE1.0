//
//  CategoryQueryInfoReq.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "RequestBean.h"

@interface CategoryQueryInfoReq : RequestBean

@property NSString * type;
@property NSString * timeMin;
@property NSString * timeMax;
@property NSString * creator;
@property NSString * keyWords;
@property NSString * orgseq;
@property NSString * dealer;

@end
