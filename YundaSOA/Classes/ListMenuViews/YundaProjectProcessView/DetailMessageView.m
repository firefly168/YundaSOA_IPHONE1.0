//
//  DetailMessageView.m
//  YundaSOA
//
//  Created by tyson on 13-7-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "DetailMessageView.h"
#import "yundaData.h"

@implementation DetailMessageView

- (id)initWithFrame:(CGRect)frame CountItems:(NSInteger)countItems ItemHeightArray:(NSMutableArray *)itemsHeightArray
{
    countItem = countItems;
    itemHeightArray = itemsHeightArray;
    if (self = [super initWithFrame:frame]) {
        //        messageTable = [[UITableView alloc] init];
        //        messageTable.delegate = self;
        //        messageTable.dataSource = self;
        //        [self addSubview:messageTable];
        
        for (int j = 0; j < countItems; j ++) {
            if (messageView[j] == nil) {
                messageView[j] = [[MessageView alloc] initWithCount:j+1];
                messageView[j].backgroundColor = [UIColor redColor];
                [self addSubview:messageView[j]];
            }
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int j = 0; j < countItem; j ++) {
        CGFloat X_pixel = (j%2 != 0 ? 450 : 0);
        CGFloat Y_pixel = [[itemHeightArray objectAtIndex:j] floatValue] + 105;
        messageView[j].frame = CGRectMake(X_pixel, Y_pixel - 25, 150, 50);
        X_pixel = (j%2 != 0 ? 300 : 50);
        CGDrawLine(context, X_pixel, Y_pixel, X_pixel + 200, Y_pixel, [UIColor blackColor]);
    }
    [messageTable setFrame:CGRectMake(0, 0, 200, 300)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"selected is %d",[indexPath row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setHidden:YES];
}

@end

@implementation MessageView

- (id)initWithCount:(NSInteger)count
{
    if (self = [super init]) {
        msgLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
        msgLable.text = [NSString stringWithFormat:@"%d",count];
        msgLable.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = rect;
    [detailBtn setBackgroundImage:[UIImage imageNamed:@"image2.jpg"] forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:detailBtn];
    
    msgLable.textColor = [UIColor redColor];
    [self addSubview:msgLable];
    [self bringSubviewToFront:msgLable];
}

- (void)detailBtnClicked:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSecondMsg" object:nil userInfo:nil];
}
@end