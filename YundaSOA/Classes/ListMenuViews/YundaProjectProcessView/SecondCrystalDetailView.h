//
//  SecondCrystalDetailView.h
//  YundaSOA
//
//  Created by tyson on 13-7-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThirdCrystalDetailView;

@interface SecondCrystalDetailView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *secondCrystalTable;
    ThirdCrystalDetailView *thirdCrystal;
    NSInteger countItem;
    NSNumber *currentItemHeightNumber;
}

- (id)initWithFrame:(CGRect)frame CountItems:(NSInteger)countItems ItemHeightNumber:(NSNumber *)itemHeightNumber;

@end

@interface ThirdCrystalDetailView : UIView
{
    UILabel *label[8];
    NSArray *titleArray;
}

@end