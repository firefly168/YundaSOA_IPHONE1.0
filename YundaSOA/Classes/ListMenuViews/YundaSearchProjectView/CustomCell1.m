//
//  CustomCell1.m
//  Animated Table
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "CustomCell1.h"

// Example Cell
#define defaultPadding 25
#define sizeCellWidth 810
#define sizeCellHeight 80
#define sizePicture 25
#define sizeTitleWidth 200
#define sizeTitleheight 20
#define intervalX 400

@implementation ProgressView

- (id)initWithProgressViewStyle:(UIProgressViewStyle)style
{
    if (self = [super initWithProgressViewStyle:style]) {
        proglabel = [[UILabel alloc] init];
        proglabel.frame = CGRectMake(20, 0, 160, 20);
        [self addSubview:proglabel];
    }
    return self;
}

- (void)layoutSubviews:(NSString *)title
{
    proglabel.text = title;
}
@end

@implementation CustomCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // User customization
        bgimageView = [[UIImageView alloc] init];
        [bgimageView setImage:[UIImage imageNamed:@"transparent.png"]];
        bgimageView.alpha = 1.7;
        [self.atcContentView addSubview:bgimageView];
        
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        
        pProgress1 = [[UIProgressBar alloc] initWithFrame:CGRectMake(100, 30, 200, 20)];
        pProgress1.minValue = 1;
        pProgress1.maxValue = 10;
        pProgress1.currentValue = 5;
        [pProgress1 setLineColor:[UIColor redColor]];
        [pProgress1 setProgressColor:[UIColor blueColor]];
        [pProgress1 setProgressRemainingColor:[UIColor yellowColor]];
        [bgView addSubview:pProgress1];
        
        for (int i = 0; i < 6; i ++) {
            label[i] = [[UILabel alloc] init];
            label[i].backgroundColor = [UIColor clearColor];
            [bgView addSubview:label[i]];
        }

        [self.atcContentView addSubview:bgView];
    }
    return self;
}

- (void)showAllMessageOnView:(ProjectInfoBean *)projectList
{
    cellInfo = projectList;
    [self layoutSubviews];
}

- (NSString *)transferTimeStyle:(long long)_time
{
    long long time = _time;
    NSDate *currentday = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *dayDateFormatter1 = [[NSDateFormatter alloc] init];
    dayDateFormatter1.dateFormat = @"YYYY-MM-dd";
    NSString *dayStr = [dayDateFormatter1 stringFromDate:currentday];
    
    //注意：NSDate和NSDateComponents拿到的天数会差一天，获取单独的年月日用NSDateComponents方法
//    NSCalendar *ca = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comp = [ca components:NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit fromDate:currentday];
//    dayStr1 = [NSString stringWithFormat:@"%d-%02d-%02d",comp.year,comp.month,comp.day + 1];
    return dayStr;
}

- (void)layoutSubviews
{
    bgView.frame = CGRectMake(defaultPadding, defaultPadding,sizeCellWidth, sizeCellHeight);
    bgimageView.frame = bgView.frame;

    label[0].frame = CGRectMake(defaultPadding , 5, sizeTitleWidth, sizeTitleheight);
    label[1].frame = CGRectMake(defaultPadding + intervalX, 5, sizeTitleWidth, sizeTitleheight);
    label[2].frame = CGRectMake(defaultPadding, 5 + (sizeTitleheight + 3), sizeTitleWidth, sizeTitleheight);
    label[3].frame = CGRectMake(defaultPadding + intervalX, 5 + (sizeTitleheight + 3), sizeTitleWidth, sizeTitleheight);
//    label[4].frame = CGRectMake(defaultPadding, 5 + (sizeTitleheight + 3)*2, sizeTitleWidth + 120, sizeTitleheight);
    pProgress1.frame = CGRectMake(defaultPadding, 5 + (sizeTitleheight + 3)*2, sizeTitleWidth + 120, 30);
    [pProgress1 layoutIfNeeded];
    
    label[5].frame = CGRectMake(defaultPadding + intervalX, 5 + (sizeTitleheight + 3)*2, sizeTitleWidth, sizeTitleheight);

    if (cellInfo) {
        NSString *proStr = [NSString stringWithFormat:@"%@ (%@) %@%% %@",[self transferTimeStyle:cellInfo.prStartTime],cellInfo.prdegree,cellInfo.prPercentage,[self transferTimeStyle:cellInfo.prEndTime]];
        label[0].text = [NSString stringWithFormat:@"%@",cellInfo.prCode];
        label[1].text = [NSString stringWithFormat:@"项目发起人:%@",cellInfo.prFqName];
        label[2].text = [NSString stringWithFormat:@"%@",cellInfo.prsName];
        label[3].text = [NSString stringWithFormat:@"项目负责人:%@",cellInfo.prFzName];
        label[4].text = proStr;
        label[4].backgroundColor = [UIColor yellowColor];

        pProgress1.currentValue = [cellInfo.prPercentage intValue]*10/100.0;
        pProgress1.titleLbl.text = proStr;
        
        label[5].text = [NSString stringWithFormat:@"创建时间:%@",[self transferTimeStyle:cellInfo.prCreateTime]];
    }
}
@end
