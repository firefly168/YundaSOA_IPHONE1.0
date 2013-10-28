//
//  yundaData.m
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaData.h"
#import "yundaAppDelegate.h"

@implementation yundaData

NSString* getMyBundlePath( NSString * filename)
{
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename )
	{
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

void CGFillRect(CGContextRef context,CGRect rt,UIColor *color)
{
	CGContextSetAllowsAntialiasing(context,NO);
	CGContextSetStrokeColorWithColor(context,color.CGColor);
	CGContextSetFillColorWithColor(context,color.CGColor);
	CGContextAddRect(context,rt);
	CGContextDrawPath(context,kCGPathFillStroke);
}

void CGDrawLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color)
{
	CGContextSetAllowsAntialiasing(context,NO);
	CGContextSetStrokeColorWithColor(context,color.CGColor);
	CGContextMoveToPoint(context, x1,y1);
	CGContextAddLineToPoint(context, x2,y2);
	CGContextStrokePath(context);
}

void CGDrawLineSmooth( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color)
{
	CGContextSetAllowsAntialiasing(context,YES);
	CGContextSetStrokeColorWithColor(context,color.CGColor);
	CGContextMoveToPoint(context, x1,y1);
	CGContextAddLineToPoint(context, x2,y2);
	CGContextStrokePath(context);
}
@end
