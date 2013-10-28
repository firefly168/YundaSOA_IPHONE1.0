//
//  yundaPersonalTargetView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaData.h"

@class BaseHeadView,PersonalTableView,PersonalCell,PersonalSearchPopoverView;
@interface yundaPersonalTargetView : UIView
{
    BaseHeadView *_baseHeadView;
    PersonalTableView *_personalTableView;
    PersonalCell *_personalCell;
}

@end

@interface PersonalTableView : UIView

@end

@interface PersonalCell : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *subTable;
    PersonalSearchPopoverView *personalPopvier;
}

- (id)initWithFrame:(CGRect)frame CellIndexString:(NSString *)cellIndexString;

@end