//
//  DepartmentTableViewCell.h
//  YundaSOA
//
//  Created by tyson on 13-7-26.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentTableViewCell : UITableViewCell
{
    UILabel *label[5];
}

@property (nonatomic)                   NSInteger       level;
@property (nonatomic, strong) IBOutlet    UIImageView*    iconView;
@property (nonatomic, strong) IBOutlet    UILabel*        contextLabel;

@end
