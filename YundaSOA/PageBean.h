//
//  PageBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface PageBean : Jastor

@property NSNumber * itemCount;
@property NSNumber * pageCount;
@property NSNumber * itemOfPage;
@property NSNumber * currentPage;

@end
