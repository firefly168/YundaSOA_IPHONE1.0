//
//  PageView.m
//  YundaSOA
//
//  Created by tyson on 13-7-29.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "PageView.h"

@implementation PageView
@synthesize delegate = _delegate;

- (id)init
{
    if (self = [super init]) {
        for (int i = 0; i < 2; i ++) {
            label[i] = [[UILabel alloc] init];
            [self addSubview:label[i]];
        }
        for (int i = 0; i < 4; i ++) {
            button[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            button[i].tag = 0x01 + i;
            [button[i] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button[i] setBackgroundImage:[UIImage imageNamed:@"transparent.png"] forState:UIControlStateNormal];
            button[i].backgroundColor = [UIColor grayColor];
            [self addSubview:button[i]];
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 0x01) {
        currentPage = 0;  //回首页
    } else if (sender.tag == 0x02) {
        currentPage --;
        if (currentPage < 0) {
            currentPage = pageCount - 1;
        }
    } else if (sender.tag == 0x03) {
        currentPage ++;
        if (currentPage > pageCount - 1) {
            currentPage = 0;
        }
    } else {
        currentPage = pageCount - 1;//到尾页
    }
    [self.delegate reloadDetailProjectViewCellData:currentPage];
}

- (void)transferDataToView:(PageBean *)page
{
    NSLog(@"%@",page);
    CGFloat begin_x = 40;
    CGFloat begin_y = 5;
    CGFloat interval_x = 10;
    
    label[0].frame = CGRectMake(begin_x, begin_y, 120, 25);
    label[1].frame = CGRectMake(label[0].frame.origin.x + label[0].frame.size.width + interval_x, begin_y, 120, 25);
    button[0].frame = CGRectMake(label[1].frame.origin.x + label[1].frame.size.width + interval_x, begin_y, 50, 25);
    button[1].frame = CGRectMake(button[0].frame.origin.x + button[0].frame.size.width + interval_x, begin_y, 50, 25);
    button[2].frame = CGRectMake(button[1].frame.origin.x + button[1].frame.size.width + interval_x, begin_y, 50, 25);
    button[3].frame = CGRectMake(button[2].frame.origin.x + button[2].frame.size.width + interval_x, begin_y, 50, 25);
    
    label[0].text = [NSString stringWithFormat:@"共 %d 条纪录", [page.itemCount intValue]];
    label[1].text = [NSString stringWithFormat:@"第 %d 页/共 %d 页",[page.currentPage intValue] + 1,[page.pageCount intValue]];
    
    currentPage = [page.currentPage intValue];
    pageCount = [page.pageCount intValue];
    
    [button[0] setTitle:@"首页" forState:UIControlStateNormal];
    [button[1] setTitle:@"上页" forState:UIControlStateNormal];
    [button[2] setTitle:@"下页" forState:UIControlStateNormal];
    [button[3] setTitle:@"尾页" forState:UIControlStateNormal];
}

@end
