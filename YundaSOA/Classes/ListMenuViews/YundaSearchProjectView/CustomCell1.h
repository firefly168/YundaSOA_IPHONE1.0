//
//  CustomCell1.h
//  Animated Table
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "AnimatedTableCell.h"
#import "ProjectInfoBean.h"
#import "UIProgressBar.h"

@interface ProgressView : UIProgressView
{
    UILabel *proglabel;
}
@end

@interface CustomCell1 : AnimatedTableCell
{
    ProjectInfoBean *cellInfo;
    UILabel *label[6];
    UIView *bgView;
    UIImageView *bgimageView;
    ProgressView *proView;
    UIProgressBar *pProgress1;
}

- (void)showAllMessageOnView:(ProjectInfoBean *)projectList;

@end
