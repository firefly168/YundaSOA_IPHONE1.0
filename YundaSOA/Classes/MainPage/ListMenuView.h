//
//  ListMenuView.h
//  YundaSOA
//
//  Created by tyson on 13-7-25.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListMenuDelegate <NSObject>

@optional
- (void)showSelectedView:(int)index;

@end

@interface ListMenuTableView : UITableView

@end

@interface ListMenuView : UIView

@property (strong, nonatomic) IBOutlet ListMenuTableView *listMenuTableView;
@property (nonatomic,assign)   id<ListMenuDelegate> listmenudelegate;

@end
