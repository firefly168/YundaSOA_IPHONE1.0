//
//  DeptTableRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface DeptTableRes : ResponseBean

@property NSArray * mGallyArray;
@property NSArray * blocks;
@property NSArray * centers;
@property NSString * prTemplate;

+(Class) mGallyArray_class;
+(Class) blocks_class;
+(Class) centers_class;

@end
