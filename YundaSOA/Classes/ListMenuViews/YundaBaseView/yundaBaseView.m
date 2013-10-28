//
//  yundaBaseView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaBaseView.h"
#import "yundaSelfTargetFinishedView.h"
#import "ETCellModel.h"
#import "BaseTableViewCell.h"
#import "DepartmentTableViewCell.h"

@implementation yundaBaseView

- (void)hideTableView:(UIButton *)sender
{
    if (departmentTableView == nil) {
        departmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(detailView.frame.origin.x + 20, (detailView.frame.origin.y + departmentButton.frame.origin.y + departmentButton.frame.size.height + 20), detailView.frame.size.width - 40, 500) style:UITableViewStylePlain];
        departmentTableView.delegate = self;
        departmentTableView.dataSource = self;
        departmentTableView.tag = 0x10;
        departmentTableView.hidden = YES;
        [self addSubview:departmentTableView];
    }
    if (sender.tag == 0x10) {
        baseTableView.hidden = NO;
        departmentTableView.hidden = YES;
    } else {
        baseTableView.hidden = YES;
        departmentTableView.hidden = NO;
    }
}

- (void)drawRect:(CGRect)rect
{
    _baseHeadView = [[BaseHeadView alloc] initWithFrame:CGRectMake(100, 10, 700, 80) HeadTitle:@"所有部门目标达成率"];
    [self addSubview:_baseHeadView];
    
    detailView = [[UIView alloc] init];
    detailView.frame = CGRectMake(30, _baseHeadView.frame.size.height + 30, 800, 700);
    [self addSubview:detailView];
    UIImageView *bgImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    bgImageview.frame = CGRectMake(0, 0, detailView.frame.size.width, detailView.frame.size.height);
    [detailView addSubview:bgImageview];
    
    baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseButton setBackgroundImage:[UIImage imageBundleNamed:@"p_buttonBlue.png"] forState:UIControlStateNormal];
    CGRect baseButtonRect = CGRectMake(20, 25, 200, 50);
    [baseButton setTitle:@"1 总部各部门" forState:UIControlStateNormal];
    [baseButton setFrame:baseButtonRect];
    baseButton.tag = 0x10;
    [baseButton addTarget:self action:@selector(hideTableView:) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:baseButton];
    
    departmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [departmentButton setBackgroundImage:[UIImage imageBundleNamed:@"p_buttonBlue.png"] forState:UIControlStateNormal];
    CGRect departmentButtonRect = CGRectMake(240, 25, 200, 50);
    
    [departmentButton setTitle:@"2 省公司+分拨中心" forState:UIControlStateNormal];
    [departmentButton setFrame:departmentButtonRect];
    departmentButton.tag = 0x11;
    [departmentButton addTarget:self action:@selector(hideTableView:) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:departmentButton];
    
    if (baseTableView == nil) {
        baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(detailView.frame.origin.x + 20, (detailView.frame.origin.y + departmentButton.frame.origin.y + departmentButton.frame.size.height + 20), detailView.frame.size.width - 40, 500) style:UITableViewStylePlain];
        baseTableView.delegate = self;
        baseTableView.dataSource = self;
        baseTableView.tag = 0x11;
        //            UIImageView *bgImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellbg.png"]];
        //            bgImageview.frame = CGRectMake(0, 0, baseTableView.frame.size.width, baseTableView.frame.size.height);
        //            [baseTableView addSubview:bgImageview];
        //            bgImageview.alpha = 0.2;
        //            [baseTableView sendSubviewToBack:bgImageview];
        //            baseTableView.backgroundColor = [UIColor clearColor];
        baseTableView.hidden = NO;
        [self addSubview:baseTableView];
    }
    
    _tableViewDataSource = [[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {
        [self dataFiller:0];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"loginbackground.png"]];
    [self addSubview:bgImageView];
    bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self sendSubviewToBack:bgImageView];
}

#define kMaxDeep 7

- (void) dataFiller:(NSInteger) level
{
    ETCellModel* model = [[ETCellModel alloc] init];
    model.level = level;
    model.hide = (1 << (kMaxDeep - level)) - 1;
    [_tableViewDataSource addObject:model];
    
    if (level != kMaxDeep - 1)
    {
        int t = random() % 3 + 1;
        for (int i=0; i<t; i++)
            [self dataFiller:level + 1];
    }
}

const static int kShowFlag = (1 << kMaxDeep) -1;

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int n = 0;
    if (tableView.tag == 0x10) {
        for (ETCellModel* model in _tableViewDataSource) {
            if (model.hide == kShowFlag) n ++ ;
        }
        return n;
    } else {
        for (ETCellModel* model in _tableViewDataSource) {
            if (model.hide == kShowFlag) n ++ ;
        }
        return n;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0x10) {
        int t = -1;
        ETCellModel* m;
        for (ETCellModel* model in _tableViewDataSource) {
            if (model.hide == kShowFlag) t ++;
            if (t == indexPath.row) {
                m = model;
                break;
            }
        }
        
        static NSString* key = @"default";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
        if (nil == cell)
        {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"default"];
        }
        cell.level = m.level;
        
        //添加双击cell之后的响应事件
        UITapGestureRecognizer *doubleTabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTabGesture setNumberOfTapsRequired:2];
        [cell addGestureRecognizer:doubleTabGesture];
        [cell layoutSubviews];
        return cell;
    } else {
        int t = -1;
        ETCellModel* m;
        for (ETCellModel* model in _tableViewDataSource) {
            if (model.hide == kShowFlag) t ++;
            if (t == indexPath.row) {
                m = model;
                break;
            }
        }
        
        static NSString* key = @"default";
        DepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
        if (nil == cell)
        {
            cell = [[DepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"default"];
        }
        cell.level = m.level;
        
        //添加双击cell之后的响应事件
        UITapGestureRecognizer *doubleTabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTabGesture setNumberOfTapsRequired:2];
        [cell addGestureRecognizer:doubleTabGesture];
        [cell layoutSubviews];
        return cell;
    }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)sender
{
    NSLog(@"被双击了！！！！");
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int t = -1, p = 0;
    ETCellModel* m;
    for (ETCellModel* model in _tableViewDataSource) {
        if (model.hide == kShowFlag) t ++;
        if (t == indexPath.row) {
            m = model;
            break;
        }
        p++;
    }
    
    if (m.level == 6) return;
    
    p ++;
    if (p == _tableViewDataSource.count) return;
    ETCellModel* nxtModel = _tableViewDataSource[p];
    if (nxtModel.level > m.level)
    {
        if (nxtModel.hide == kShowFlag)
        {
            NSMutableArray* arr = [NSMutableArray array];
            while (true)
            {
                if (nxtModel.hide == kShowFlag)
                {
                    t ++;
                    NSIndexPath* path = [NSIndexPath indexPathForRow:t inSection:0];
                    [arr addObject:path];
                }
                nxtModel.hide ^= 1 << (kMaxDeep - m.level - 1);
                p ++;
                if (p == _tableViewDataSource.count) break;
                nxtModel = _tableViewDataSource[p];
                if (nxtModel.level <= m.level) break;
            }
            [tableView deleteRowsAtIndexPaths:arr
                             withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            NSMutableArray* arr = [NSMutableArray array];
            while (true)
            {
                nxtModel.hide ^= 1 << (kMaxDeep - m.level - 1);
                
                if (nxtModel.hide == kShowFlag)
                {
                    t ++;
                    NSIndexPath* path = [NSIndexPath indexPathForRow:t inSection:0];
                    [arr addObject:path];
                }
                
                p ++;
                if (p == _tableViewDataSource.count) break;
                nxtModel = _tableViewDataSource[p];
                if (nxtModel.level <= m.level) break;
            }
            [tableView insertRowsAtIndexPaths:arr
                             withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

/*  触摸事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    int a = [touch tapCount];
    if (a == 2) {
        NSLog(@"success");
    }
}
 */

@end
