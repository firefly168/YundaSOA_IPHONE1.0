
#import "MyColor.h"

@implementation UIColor (MyColor)

UIColor* getColorFromRGB(int red,int green,int blue)
{
	return [[UIColor alloc] initWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];	
}
+(UIColor*)rgbFromIndex:(int)index
{
	static UIColor* color = nil;
	switch (index) {
		case 0:
			color = [UIColor rgbBackGround];
			break;
		case 1:
			//color = [UIColor rgbBorder];
			color = [UIColor redColor];
			break;
		case 2:
			color = [UIColor rgbToolBar];
			break;
		case 3:
			color = [UIColor purpleColor];
			break;
		case 4:
			color = [UIColor grayColor];
			break;
		case 5:
			color = [UIColor grayColor];
			break;
		default:
			break;
	}
	
	return color;
}

+(UIColor*)rgbToolBar
{
	static UIColor*	colorBackGround = nil;
	if(colorBackGround == nil)
	{
		colorBackGround = getColorFromRGB(0x00, 0x1F, 0x56);
	}
	return colorBackGround;
}

+(UIColor*)rgbScrollBG
{
	static UIColor*	colorBackGround = nil;
	if(colorBackGround == nil)
	{
		colorBackGround = getColorFromRGB(0x10, 0x4e, 0x8b);
	}
	return colorBackGround;
}

+(UIColor*)rgbBackGround
{
    return RGBCOLOR(218, 218, 218);
//	return RGBCOLOR(0x07, 0x20, 0x3a);
}

+(UIColor*)rgbBorder
{
	return RGBCOLOR(0x80, 0x00, 0x00);
}

+(UIColor*)rgbIPADBorder
{
    return RGBCOLOR(152,202,226);
//	return RGBCOLOR(42,110,130);
}


+(UIColor*)rgbText
{
    return RGBCOLOR(0, 0, 0);
//	return RGBCOLOR(0xff, 0xff, 0xff);
}

+(UIColor*)rgbHighLight
{
    return RGBCOLOR(12, 70, 114);
//	return RGBCOLOR(0xff, 0xff, 0x00);
}

+(UIColor*)rgbName
{
	return RGBCOLOR(125, 205, 243);
}
+(UIColor*)rgbNameCode
{
//	return RGBCOLOR(0x00, 0xff, 0xff);
//    return RGBCOLOR(12, 99, 194);
    return [UIColor rgbVolumn];
}

+(UIColor*)rgbRise
{
return RGBCOLOR(222, 0, 11);
//	return RGBCOLOR(0xff, 0x60, 0x60);
}

+(UIColor*)rgbFall;
{
    return RGBCOLOR(23, 176, 27);
//	return RGBCOLOR(0x00, 0xff, 0x60);
}

+(UIColor*)rgbEqual
{
    return [UIColor blackColor];
//	return RGBCOLOR(0xff, 0xff, 0xff);
}

+(UIColor*)rgbVolumn
{
//    return RGBCOLOR(33, 45, 255);
    return  RGBCOLOR(11, 91, 169);
//	return RGBCOLOR(0xff, 0xff, 0x00);
}

+(UIColor*)rgbAmount
{
    return [UIColor blackColor];
// return RGBCOLOR(12, 99, 194);
//	return RGBCOLOR(0x00, 0xff, 0xff);
}

+(UIColor*)rgbLine1
{
    return  RGBCOLOR(179, 106, 0);
}

+(UIColor*)rgbLine2
{
	return RGBCOLOR(0xff, 0xff, 0x00);
}

+(UIColor*)rgbLine3
{
	return RGBCOLOR(0xff, 0x00, 0xff);
}

+(UIColor*)rgbPicFall
{
	return [self rgbFall];
}

+(UIColor*)rgbHL_BG
{
	return RGBCOLOR(0x00, 0x60, 0xff);
}

+(UIColor*)rgbInd:(int)index withIndType:(int)indType
{
	if (indType == 1) {
		switch (index) {
			case 0:
			{
				return RGBCOLOR(0xdb, 0x06, 0xe6);
			}
			case 1:
			{
				return RGBCOLOR(0xff, 0xff, 0x00);
			}
			case 2:
			{
				return RGBCOLOR(0x29, 0x98, 0xc2);
			}
			case 3:
			{
				return RGBCOLOR(0x00, 0xce, 0x00);
			}
			default:
				break;
		}
	}
    else if (indType == 2)
    {
        switch (index) {
			case 0:
			case 2:
			{
				return RGBCOLOR(0xff, 0xff, 0xff);//ÁôΩËâ≤
			}
                break;
			case 1:
			{
                return RGBCOLOR(255, 0, 253);//Á≤âËâ≤
			}
                break;
			default:
				break;
		}
    }
    else if (indType == 3)
    {
        switch (index) {
			case 0:
			{
				return RGBCOLOR(12, 70, 114);//蓝色//RGBCOLOR(0xff, 0xff, 0xff);//ÁôΩËâ≤
			}
                break;
			case 1:
			{
                return [UIColor rgbRise];
			}
                break;
            case 2:
			{
                return [UIColor rgbFall];
			}
            case 3:
			{
				return RGBCOLOR(255, 180, 0);//亮黄色
			}
                break;
			default:
				break;
		}
    }
	else
    {
        switch (index) {
            case 0:
			{
				return RGBCOLOR(15, 222, 238);//蓝色
			}
			case 1:
			{
                return RGBCOLOR(255, 180, 0);//黄色
			}
			case 2:
			{
                return RGBCOLOR(255, 76, 148);//粉色
			}
			case 3:
			{
                return RGBCOLOR(255, 73, 76);//红色
			}
            case 4:
			{
                return [UIColor rgbNameCode];//RGBCOLOR(0, 0, 255);//蓝色
			}
			default:
				break;
		}

	}
	return nil;
}

+(UIColor*)rgbZJBY:(int)index
{
	switch (index) {
		case 0:
		{
			return RGBCOLOR(0xdb, 0x06, 0xe6);
		}
		case 1:
		{	
			return RGBCOLOR(0xff, 0xff, 0x00);
		}
		case 2:
		{
			return RGBCOLOR(0x29, 0x98, 0xc2);
		}
		case 3:
		{
			return RGBCOLOR(0x00, 0xce, 0x00);
		}
		default:
			break;
	}
	return nil;
}

+(UIColor*)rgbSell:(int)index
{
	switch (index) {
		case 0:
		{
			return RGBCOLOR(0x00, 0x55, 0x55);
		}
		case 1:
		{
			return RGBCOLOR(0x00, 0x7f, 0x7f);
		}
		case 2:
		{
			return RGBCOLOR(0x00, 0xaa, 0xaa);
		}
		case 3:
		{
			return RGBCOLOR(0x00, 0xe0, 0xe0);
		}
		default:
			break;
	}
	return nil;
}

+(UIColor*)rgbBuy:(int)index
{
	switch (index) {
		case 0:
		{
			return RGBCOLOR(0x55, 0x20, 0x20);
		}
		case 1:
		{
			return RGBCOLOR(0x7f, 0x30, 0x30);
		}
		case 2:
		{
			return RGBCOLOR(0xaa, 0x40, 0x40);
		}
		case 3:
		{
			return RGBCOLOR(0xff, 0x60, 0x60);
		}
		default:
			break;
	}
	return nil;
}

+(UIColor*)rgbMemo
{
	return RGBCOLOR(0xc0, 0xc0, 0xc0);
}
+(UIColor*)rgbBlue
{
	return RGBCOLOR(0x1c, 0x86, 0xee);
}
+(UIColor*)rgbDarkGray
{
	return RGBCOLOR(0x20, 0x20, 0x20);
}

+(UIColor*)rgbDDBLRise
{
	return RGBCOLOR(0xff, 0xbb, 0xbb);
}

+(UIColor*)rgbDDBLFall
{
	return RGBCOLOR(0x6d, 0xd1, 0xf8);
}

+(UIColor*)rgbCJZJ:(int)index
{
	switch (index) {
		case 0:
		{
			return RGBCOLOR(0xff, 0xff, 0xff);
		}
		case 1:
		{
			return RGBCOLOR(0xff, 0x60, 0xff);
		}
		case 2:
		{
			return RGBCOLOR(0xff, 0xff, 0xff);
		}
		default:
			break;
	}
	return nil;
}

+(UIColor*)rgbDarkRed
{
	return RGBCOLOR(88, 3, 3);
}

+ (UIColor *)rgbDarkBlue
{
	return RGBCOLOR(18,49,68);
}

+ (UIColor *)rgbSeparateLine
{
	return RGBCOLOR(200,200,200);
}

+ (UIColor *)thisGrayColor
{
	return RGBCOLOR(226,226,226);
}

+ (UIColor *)gridColor
{
	return RGBCOLOR(219,219,219);
}
+(UIColor *)rgbDarkYellowColor
{
    return RGBCOLOR(246, 149, 29);
}

+(UIColor *)rgbSHZJ:(int)index
{
    switch (index) {
		case 0:
		{
			return RGBCOLOR(0xff, 0xff, 0xff);
		}
		case 1:
		{
			return RGBCOLOR(0x00, 0xff, 0x60);
		}
		case 2:
		{
			return RGBCOLOR(0xff, 0xff, 0xff);
		}
		default:
			break;
	}
	return nil;
}

+ (UIColor *)rgbContentColor
{
    return RGBCOLOR(83, 83, 83);
}

//每月环比的颜色值
+(UIColor *)rgbMYHB:(int)index DetailColor:(int)detailColor
{
    switch (index) {
		case 0:
		{
            //purple
            if (detailColor == 0) {
                return RGBCOLOR(134, 19, 255);
            } else if (detailColor == 1) {
                return RGBCOLOR(144, 19, 255);
            } else {
                return RGBCOLOR(144, 26, 255);
            }
		}
		case 1:
		{
            //orange
            if (detailColor == 0) {
                return RGBCOLOR(232, 140, 61);
            } else if (detailColor == 1) {
                return RGBCOLOR(252, 150, 63);
            } else {
                return RGBCOLOR(252, 170, 64);
            }
		}
		case 2:
		{
            //red
            if (detailColor == 0) {
                return RGBCOLOR(251,3,41);
            } else if (detailColor == 1) {
                return RGBCOLOR(252,77,105);
            } else {
                return RGBCOLOR(251,32,29);
            }
		}
        case 3:
		{
            //blue
            if (detailColor == 0) {
                return RGBCOLOR(41,64,255);
            } else if (detailColor == 1) {
                return RGBCOLOR(65,80,255);
            } else {
                return RGBCOLOR(73,57,255);
            }
		}
		case 4:
		{
            if (detailColor == 0) {
                return RGBCOLOR(94, 148, 55);
            } else if (detailColor == 1) {
                return RGBCOLOR(94, 158, 55);
            } else {
                return RGBCOLOR(104, 158, 55);
            }
		}
		case 5:
		{
            if (detailColor == 0) {
                return RGBCOLOR(52, 92, 137);
            } else if (detailColor == 1) {
                return RGBCOLOR(57, 92, 137);
            } else {
                return RGBCOLOR(57, 99, 137);
            }
		}
        case 6:
		{
            if (detailColor == 0) {
                return RGBCOLOR(37, 42, 40);
            } else if (detailColor == 1) {
                return RGBCOLOR(42, 42, 40);
            } else {
                return RGBCOLOR(42, 42, 45);
            }
		}
		case 7:
		{
            if (detailColor == 0) {
                return RGBCOLOR(170, 136, 36);
            } else if (detailColor == 1) {
                return RGBCOLOR(180, 136, 36);
            } else {
                return RGBCOLOR(180, 136, 46);
            }
		}
		case 8:
		{
            if (detailColor == 0) {
                return RGBCOLOR(166, 66, 70);
            } else if (detailColor == 1) {
                return RGBCOLOR(166, 76, 70);
            } else {
                return RGBCOLOR(156, 66, 70);
            }
		}
        case 9:
		{
            if (detailColor == 0) {
                return RGBCOLOR(225, 145, 29);
            } else if (detailColor == 1) {
                return RGBCOLOR(235, 145, 29);
            } else {
                return RGBCOLOR(235, 150, 31);
            }
		}
		case 10:
		{
            if (detailColor == 0) {
                return RGBCOLOR(59, 130, 228);
            } else if (detailColor == 1) {
                return RGBCOLOR(67, 130, 229);
            } else {
                return RGBCOLOR(68, 137, 229);
            }
		}
		case 11:
		{
            if (detailColor == 0) {
                return RGBCOLOR(110, 131, 148);
            } else if (detailColor == 1) {
                return RGBCOLOR(117, 132, 149);
            } else {
                return RGBCOLOR(118, 132, 157);
            }
		}
		default:
			break;
	}
	return nil;
}
@end
