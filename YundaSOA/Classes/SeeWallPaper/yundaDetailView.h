//
//  yundaDetailView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaData.h"

@class CellView;
@interface yundaDetailView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_secondView;
    CellView *_cellView;
    UITableView *_contentTableView;
}

@end

@interface CellView : UIView

@end

@class ProposerCellView;
@interface PersonalSearchPopoverView : yundaDetailView
{
    UITableView *leftTableView;
    UITableView *rightTableView;
    ProposerCellView *proposerCell;
    id<yundaDataDelegate> delegate;
}

@property (nonatomic,assign) id<yundaDataDelegate> delegate;

@end

@interface ProposerCellView : UIView

@end