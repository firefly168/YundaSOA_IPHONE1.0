//
//  yundaBaseView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaDetailView.h"
#import "UIView+Positioning.h"

@class BaseHeadView;
@interface yundaBaseView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *departmentTableView;
    UITableView *baseTableView;
    BOOL isShrink;
    BaseHeadView *_baseHeadView;
    UIView *detailView;
    UIButton *baseButton;
    UIButton *departmentButton;
    
    NSMutableArray *_tableViewDataSource;
}

@end
