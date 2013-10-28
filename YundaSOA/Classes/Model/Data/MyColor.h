//
//  MyColor.h
//  EMStock
//
//  Created by wang bin on 09-8-22.
//  Copyright 2009 EMONEY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1)

@interface UIColor (MyColor)

+(UIColor*)rgbBackGround;
+(UIColor*)rgbBorder;
+(UIColor*)rgbIPADBorder;
+(UIColor*)rgbText;
+(UIColor*)rgbHighLight;
+(UIColor*)rgbNameCode;
+(UIColor*)rgbName;
+(UIColor*)rgbRise;
+(UIColor*)rgbFall;
+(UIColor*)rgbEqual;
+(UIColor*)rgbVolumn;
+(UIColor*)rgbAmount;
+(UIColor*)rgbLine1;
+(UIColor*)rgbLine2;
+(UIColor*)rgbLine3;
+(UIColor*)rgbPicFall;
+(UIColor*)rgbHL_BG;
+(UIColor*)rgbInd:(int)index withIndType:(int)indType;
+(UIColor*)rgbMemo;
+(UIColor*)rgbBlue;
+(UIColor*)rgbDarkGray;
+(UIColor*)rgbZJBY:(int)index;
+(UIColor*)rgbSell:(int)index;
+(UIColor*)rgbBuy:(int)index;
+(UIColor*)rgbDDBLRise;
+(UIColor*)rgbDDBLFall;
+(UIColor*)rgbCJZJ:(int)index;
+(UIColor*)rgbDarkRed;
+ (UIColor *)rgbDarkBlue;
+ (UIColor *)rgbSeparateLine;
+ (UIColor *)gridColor;
+ (UIColor *)thisGrayColor;
+(UIColor *)rgbDarkYellowColor;
+(UIColor *)rgbSHZJ:(int)index;

+ (UIColor *)rgbContentColor;

+(UIColor *)rgbMYHB:(int)index DetailColor:(int)detailColor;
@end
