//
//  yundaDepartmentTargetView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaDepartmentTargetView.h"
#import "UIImage+embundle.h"
#import "yundaSelfTargetFinishedView.h"

@implementation yundaDepartmentTargetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
    }
    return self;
}

- (void)hideTableView:(UIButton *)sender
{
    if (departmentTableView == nil) {
        departmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, (departmentButton.frame.origin.y + departmentButton.frame.size.height + 20), detailView.frame.size.width - 40, 500) style:UITableViewStylePlain];
        departmentTableView.delegate = self;
        departmentTableView.dataSource = self;
        departmentTableView.tag = 0x10;
        departmentTableView.hidden = YES;
        [detailView addSubview:departmentTableView];
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
        baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, (departmentButton.frame.origin.y + departmentButton.frame.size.height + 20), detailView.frame.size.width - 40, 500) style:UITableViewStylePlain];
        baseTableView.delegate = self;
        baseTableView.dataSource = self;
        baseTableView.tag = 0x11;
        UIImageView *bgImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellbg.png"]];
        bgImageview.frame = CGRectMake(0, 0, baseTableView.frame.size.width, baseTableView.frame.size.height);
        [baseTableView addSubview:bgImageview];
        bgImageview.alpha = 0.2;
        [baseTableView sendSubviewToBack:bgImageview];
        //            baseTableView.backgroundColor = [UIColor clearColor];
        baseTableView.hidden = NO;
        [detailView addSubview:baseTableView];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"loginbackground.png"]];
    [self addSubview:bgImageView];
    bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    [self sendSubviewToBack:bgImageView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0x10) {
        if (section == 0) {
            if (isShrink)
                return 1;
            else
                return 5;
        } else
            return 5;
    } else {
        if (section == 0) {
            if (isShrink)
                return 1;
            else
                return 5;
        } else
            return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gridCellIdentifier = @"gridcell_price";
    _departmentTableViewCell = (DepartmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:gridCellIdentifier];
    
	if (nil == _departmentTableViewCell)
	{
		_departmentTableViewCell = [[DepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"gridcell_price"];
        _departmentTableViewCell.textLabel.textAlignment = UITextAutocapitalizationTypeSentences;
		_departmentTableViewCell.textLabel.textColor = [UIColor blackColor];
        _departmentTableViewCell.textLabel.font      = [UIFont boldSystemFontOfSize:12];
        _departmentTableViewCell.detailTextLabel.textColor = _departmentTableViewCell.textLabel.textColor;
        _departmentTableViewCell.detailTextLabel.font      = _departmentTableViewCell.textLabel.font;
	}
    
    //添加双击cell之后的响应事件
    UITapGestureRecognizer *doubleTabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTabGesture setNumberOfTapsRequired:2];
    [_departmentTableViewCell addGestureRecognizer:doubleTabGesture];
    [_departmentTableViewCell layoutSubviews];
	_departmentTableViewCell.indentationWidth = 10;
    if (tableView.tag == 0x10) {
        if (indexPath.row == 0) {
            _departmentTableViewCell.textLabel.text = @"+ 所有部门";
        } else if (indexPath.row == 1)
        {
            _departmentTableViewCell.textLabel.text = @"战略协调板块";
        } else if (indexPath.row == 2)
        {
            _departmentTableViewCell.textLabel.text = @"企业战略中心";
        } else if (indexPath.row == 3)
        {
            _departmentTableViewCell.textLabel.text = @"总裁办";
        } else {
            _departmentTableViewCell.textLabel.text = @"收派网点中心";
        }
    } else {
        if (indexPath.row == 0) {
            _departmentTableViewCell.textLabel.text = @"上海市";
        } else if (indexPath.row == 1)
        {
            _departmentTableViewCell.textLabel.text = @"浙江省";
        } else if (indexPath.row == 2)
        {
            _departmentTableViewCell.textLabel.text = @"江苏省";
        } else if (indexPath.row == 3)
        {
            _departmentTableViewCell.textLabel.text = @"海南省";
        } else {
            _departmentTableViewCell.textLabel.text = @"北京市";
        }
    }
	return _departmentTableViewCell;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)sender
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        isShrink = isShrink ? NO : YES;
    }
    [tableView reloadData];
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

