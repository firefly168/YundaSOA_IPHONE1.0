//
//  SecondCrystalDetailView.m
//  YundaSOA
//
//  Created by tyson on 13-7-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "SecondCrystalDetailView.h"
#import "yundaData.h"

@implementation SecondCrystalDetailView

- (id)initWithFrame:(CGRect)frame CountItems:(NSInteger)countItems ItemHeightNumber:(NSNumber *)itemHeightNumber
{
    countItem = countItems;
    currentItemHeightNumber = itemHeightNumber;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        secondCrystalTable = [[UITableView alloc] init];
        secondCrystalTable.dataSource = self;
        secondCrystalTable.delegate = self;
        [self addSubview:secondCrystalTable];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"项目名称%d",indexPath.row + 1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (thirdCrystal) {
        [thirdCrystal removeFromSuperview];
        thirdCrystal = nil;
    }
    thirdCrystal = [[ThirdCrystalDetailView alloc] init];
    [self addSubview:thirdCrystal];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat y_pixel = [currentItemHeightNumber floatValue] + 30;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGDrawLine(context, 100, y_pixel, 300, y_pixel, [UIColor blackColor]);
    secondCrystalTable.frame = CGRectMake(205, 80, 200, 400);
    if (thirdCrystal) {
        thirdCrystal.frame = CGRectMake(400, 80, 200, 400);
    }
}

@end

@implementation ThirdCrystalDetailView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        titleArray = [[NSArray alloc] initWithObjects:
                      @"项目负责人:张三",
                      @"项目名称:htc",
                      @"项目开始时间:2013-7-12",
                      @"项目结束时间:2013-12-31",
                      @"项目负责人:李四",
                      @"项目名称:abc",
                      @"项目开始时间:2013-1-12",
                      @"项目结束时间:2013-8-12",
                      nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [bgImgView setImage:[UIImage imageNamed:@"girl.png"]];
    bgImgView.alpha = 0.5;
    [self addSubview:bgImgView];
    [self sendSubviewToBack:bgImgView];
    [self titleLabelUI];
}

- (void)titleLabelUI
{
    CGFloat x_pixel = 5;
    CGFloat y_pixel = 5;
    CGFloat intervalY = 50;
    CGFloat width = 190;
    CGFloat height = 40;
    
    for (int i = 0; i < 8; i ++) {
        if (label[i] == nil) {
            label[i] = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel, y_pixel + i*intervalY, width, height)];
        }
        label[i].text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]];
        label[i].textColor = [UIColor redColor];
        label[i].textAlignment = NSTextAlignmentLeft;
        label[i].backgroundColor = [UIColor clearColor];
        [self addSubview:label[i]];
    }
}

@end