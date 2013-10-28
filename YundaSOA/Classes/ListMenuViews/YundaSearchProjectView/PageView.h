//
//  PageView.h
//  YundaSOA
//
//  Created by tyson on 13-7-29.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBean.h"

@protocol PageViewDelegate <NSObject>
@optional
- (void)reloadDetailProjectViewCellData:(int)pageindex;
@end

@interface PageView : UIView
{
    UILabel *label[2];
    UIButton *button[4];
    int currentPage;
    int pageCount;
}

@property (nonatomic,assign) id<PageViewDelegate> delegate;

- (void)transferDataToView:(PageBean *)page;
@end
