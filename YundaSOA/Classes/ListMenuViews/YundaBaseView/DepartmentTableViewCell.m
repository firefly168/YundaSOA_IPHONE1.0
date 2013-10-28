//
//  ETTableViewCell.m
//  tableViewDemo
//
//  Created by Xiaoxuan Tang on 13-6-7.
//  Copyright (c) 2013年 txx. All rights reserved.
//

#import "DepartmentTableViewCell.h"
#define kLevelOffset    10

@implementation DepartmentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chatting_btn_add_down.png"]];
        [self addSubview:_iconView];
        
        _contextLabel = [[UILabel alloc] init];
        [self addSubview:_contextLabel];
        
        NSArray *titleArr = [NSArray arrayWithObjects:@"业务板块",@"本月完成率",@"量本利",@"全年完成率",@"200万票", nil];
        for (int i = 0; i < 5; i ++) {
            label[i] = [[UILabel alloc] init];
            label[i].textAlignment = NSTextAlignmentLeft;
            label[i].backgroundColor = [UIColor clearColor];
            label[i].text = [titleArr objectAtIndex:i];
            //            [self addSubview:label[i]];
        }
    }
    return self;
}

- (void) setLevel:(NSInteger)level
{
    _level = level;
    
    CGRect rect = _contextLabel.frame;
    rect.origin.x = 46 + kLevelOffset * _level;
    _contextLabel.frame = rect;
    
    rect = _iconView.frame;
    rect.origin.x = 20 + kLevelOffset * _level;
    rect.origin.y = 20;
    _iconView.frame = rect;
    
    _contextLabel.text = [NSString stringWithFormat:@"TableView 第 %d 级", _level + 1];
}

- (void)layoutSubviews
{
    CGFloat x_pixel = 100;
    CGFloat y_pixel = 10;
    CGFloat intervalX = 150;
    CGFloat intervalY = 25;
    CGFloat width = 120;
    CGFloat height = 20;
    
    label[0].frame = CGRectMake(x_pixel, y_pixel, width, height + 20);
    label[1].frame = CGRectMake(x_pixel + intervalX, y_pixel, width, height);
    label[2].frame = CGRectMake(x_pixel + intervalX*2, y_pixel, width, height);
    label[3].frame = CGRectMake(x_pixel + intervalX, y_pixel + intervalY, width, height);
    label[4].frame = CGRectMake(x_pixel + intervalX*2, y_pixel + intervalY, width, height);
}

@end
