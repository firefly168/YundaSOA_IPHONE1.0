//
//  yundaDepartmentTargetView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Positioning.h"
#import "DepartmentTableViewCell.h"

@class BaseHeadView;
@interface yundaDepartmentTargetView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *departmentTableView;
    UITableView *baseTableView;
    BOOL isShrink;
    BaseHeadView *_baseHeadView;
    DepartmentTableViewCell *_departmentTableViewCell;
    UIView *detailView;
    UIButton *baseButton;
    UIButton *departmentButton;
}

@end
