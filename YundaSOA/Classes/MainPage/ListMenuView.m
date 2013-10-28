//
//  ListMenuView.m
//  YundaSOA
//
//  Created by tyson on 13-7-25.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ListMenuView.h"
#import "MyColor.h"
#import "UIImage+embundle.h"
#import "ListMenuTableViewCell.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#define SHOW_SIX_LIST 0
#if SHOW_SIX_LIST
    #define LISTMENUTABLECELL_HEIGHT 30
#else
    #define LISTMENUTABLECELL_HEIGHT 50
#endif

@implementation ListMenuTableView

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    drawGradientColorInRect(context, rect, RGBCOLOR(225, 225, 225), RGBCOLOR(194, 194, 194), 0);
}

void drawGradientColorInRect(CGContextRef c, CGRect itemBgRect,UIColor *topColor,UIColor *bottomColor,CGGradientDrawingOptions options)
{
	CGContextSaveGState(c);
	CGContextClipToRect(c, itemBgRect);
	
	CGGradientRef gradient = gradientColor(topColor, bottomColor);
	CGContextDrawLinearGradient(c,
								gradient,
								itemBgRect.origin,
								CGPointMake(itemBgRect.origin.x,
											itemBgRect.origin.y + itemBgRect.size.height),
								options);
    
	CFRelease(gradient);
	CGContextRestoreGState(c);
}

CGGradientRef gradientColor(UIColor *topColor,UIColor *bottomColor)
{
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
	const CGFloat* comps = CGColorGetComponents(topColor.CGColor);
	int redTop = comps[0]*255, greenTop = comps[1]*255, blueTop = comps[2]*255; // orange color
	CGFloat alphaTop = 1;
	
	if (4 == CGColorGetNumberOfComponents(topColor.CGColor))
	{
		alphaTop = comps[3];
	}
	
	const CGFloat* compsBottom = CGColorGetComponents(bottomColor.CGColor);
	int redBottom = compsBottom[0]*255, greenBottom = compsBottom[1]*255, blueBottom = compsBottom[2]*255; // orange color
	CGFloat alphaBottom = 1;
	
	if (4 == CGColorGetNumberOfComponents(bottomColor.CGColor))
	{
		alphaBottom = comps[3];
	}
	
	CGFloat colors[] = {
		redTop / 255.0f, greenTop / 255.0f, blueTop/255.0f, alphaTop,
		redBottom/255.0f, greenBottom/255.0f, blueBottom/255.0f, alphaBottom
	};
	
	
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);
    
	return gradient;
}

@end

@implementation ListMenuView
@synthesize listMenuTableView;
@synthesize listmenudelegate = _listmenudelegate;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if SHOW_SIX_LIST
    [self.listmenudelegate showSelectedView:[indexPath row]];
#else
    [self.listmenudelegate showSelectedView:5];
#endif
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LISTMENUTABLECELL_HEIGHT;
//UDID:fb7ae5b081cef0b4c928e6266754f257cf20790c
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#if SHOW_SIX_LIST
    return 6;
#else
    return 1;
#endif
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gridCellIdentifier = @"gridcell_price";
    //自定义的cell
	ListMenuTableViewCell *cell = (ListMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:gridCellIdentifier];
    
	if (nil == cell)
	{
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListMenuTableViewCell" owner:self options:nil];
//        cell = [topLevelObjects objectAtIndex:0];
		cell = [[ListMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gridcell_price"];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font      = [UIFont boldSystemFontOfSize:12];
        
        //被选中之后的cell背景效果
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
	}
    
	cell.indentationWidth = 10;  //文字缩进宽度
    
#if SHOW_SIX_LIST
    if (indexPath.row == 0) {
        cell.textLabel.text = @"查询项目";
    } else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"总部";
    } else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"部门目标达成进度表";
    } else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"本人目标达成进度墙";
    } else if (indexPath.row == 4){
    	cell.textLabel.text = @"(新建项目)单个事项达成进度墙";
    } else {
        cell.textLabel.text = @"区域大客户开发进度";
    }
#else
    cell.textLabel.text = @"区域大客户开发进度";
#endif
	
	return cell;
}

- (void)drawRect:(CGRect)rect
{
    //设置view的显示效果，cornerRadius表示四个角的弯曲方式
    self.layer.cornerRadius = 6.0f;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.4f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
}
@end
