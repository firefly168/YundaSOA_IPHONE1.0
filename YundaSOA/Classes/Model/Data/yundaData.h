//
//  yundaData.h
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol yundaDataDelegate <NSObject>

- (void)hidePopoverView;

@end

@class yundaAppDelegate;

#define MYBUNDLE_NAME @ "ymStockHDBundle.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#define degreesToRadinas(x) (M_PI * (x)/180.0)

yundaAppDelegate *theDelegate;

@interface yundaData : NSObject

NSString * getMyBundlePath( NSString * filename);
void CGFillRect(CGContextRef context,CGRect rt,UIColor *color);
void CGDrawLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);
void CGDrawLineSmooth( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);

@end
