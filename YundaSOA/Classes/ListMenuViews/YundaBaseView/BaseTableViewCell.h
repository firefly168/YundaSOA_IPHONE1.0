//
//  ETTableViewCell.h
//  tableViewDemo
//
//  Created by Xiaoxuan Tang on 13-6-7.
//  Copyright (c) 2013年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
{
    UILabel *label[5];
}

@property (nonatomic)                   NSInteger       level;
@property (nonatomic, strong) IBOutlet    UIImageView*    iconView;
@property (nonatomic, strong) IBOutlet    UILabel*        contextLabel;

@end
