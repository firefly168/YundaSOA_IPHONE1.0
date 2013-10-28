//
//  DetailMessageView.h
//  YundaSOA
//
//  Created by tyson on 13-7-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageView;
@interface DetailMessageView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *messageTable;
    MessageView  *messageView[6];
    UILabel *lbl[6];
    NSInteger countItem;
    NSMutableArray *itemHeightArray;
}

- (id)initWithFrame:(CGRect)frame CountItems:(NSInteger)countItems ItemHeightArray:(NSMutableArray *)itemsHeightArray;

@end

@interface MessageView : UIView
{
    UIButton *detailBtn;
    UILabel *msgLable;
}

- (id)initWithCount:(NSInteger)count;
@end