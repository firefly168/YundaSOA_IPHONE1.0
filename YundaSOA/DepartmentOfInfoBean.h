//
//  DepartmentOfInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "Jastor.h"

@interface DepartmentOfInfoBean : Jastor

@property NSString * cid;
@property NSString * cname;
@property NSString * ctype;
@property NSString * cparent;
@property NSString * orgseq;
@property int undeal;
@property int dealed;
@property int total;
@property int yeartotal;
@property int yearundeal;
@property int yeardeal;
@property int monthtotal;
@property int monthundeal;
@property int monthdeal;

@end
