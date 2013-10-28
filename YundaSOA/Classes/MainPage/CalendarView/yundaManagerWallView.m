//
//  yundaManagerWallView.m
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaManagerWallView.h"

@implementation yundaWallCell

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        wallCellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

- (void)showDetail
{
    isClicked = !isClicked ? YES : NO;
    if (isClicked) {
        if (detailViewController) {
            [detailViewController.view removeFromSuperview];
            detailViewController = nil;
        }
         detailViewController = [[yundaDetailViewController alloc] init];
        [theDelegate->mainpageController.view addSubview:detailViewController.view];
//        [theDelegate->mainpageController.view setUserInteractionEnabled:NO];
//        [theDelegate->mainpageController.view setBackgroundColor:[UIColor grayColor]];
    } else {
        [detailViewController.view removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
//    CGRect titleBar_rect = CGRectMake(0, 0, 95, 100);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFillRect(context, rect, RGB(84,184,184));
    
    wallCellBtn.frame = rect;
    wallCellBtn.backgroundColor = [UIColor grayColor];
//    [wallCellBtn setTitle:[NSString stringWithFormat:@"%d",4] forState:UIControlStateNormal];
    [wallCellBtn addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:wallCellBtn];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"已完成 10%";
    label1.font = [UIFont systemFontOfSize:10];
    label1.frame = CGRectMake(5, 5, self.frame.size.width - 8, 30);
    label1.backgroundColor = [UIColor clearColor];
    [wallCellBtn addSubview:label1];
    UILabel *label2 = [[UILabel alloc] init];
    
    label2.text = @"未完成 90%";
    label2.font = [UIFont systemFontOfSize:10];
    label2.backgroundColor = [UIColor clearColor];
    label2.frame = CGRectMake(5, 45, self.frame.size.width - 8, 30);
    [wallCellBtn addSubview:label2];
}

@end

@implementation yundaManagerWallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    for (int i = 0; i < 10; i ++) {
        for (int j = 0; j < 4; j ++) {
            CGRect titleBar_rect = CGRectMake(15 + 100*i, 10 + 105*j, 95, 100);
            wallCell = [[yundaWallCell alloc] initWithFrame:titleBar_rect];
            [self addSubview:wallCell];
        }
    }
}

@end

