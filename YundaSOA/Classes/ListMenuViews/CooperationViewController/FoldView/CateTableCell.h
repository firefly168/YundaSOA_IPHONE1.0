//
//  CateTableCell.h
//  top100
//
//  Created by Dai Cloud on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateTableCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *title, *subTtile;
@property (weak, nonatomic) IBOutlet UILabel *districtName;
@property (weak, nonatomic) IBOutlet UILabel *shouldDo;
@property (weak, nonatomic) IBOutlet UILabel *haveDo;
@property (weak, nonatomic) IBOutlet UILabel *noDo;
@property (weak, nonatomic) IBOutlet UILabel *percent;
@property (weak, nonatomic) IBOutlet UIImageView *strechArrowImg;

@end
