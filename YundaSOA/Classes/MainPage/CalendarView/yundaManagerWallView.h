//
//  yundaManagerWallView.h
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyColor.h"
#import "yundaDetailViewController.h"
#import "yundaAppDelegate.h"

@interface yundaWallCell : UIView
{
    UIButton *wallCellBtn;
    BOOL isClicked;
    yundaDetailViewController *detailViewController;
}

@end

@interface yundaManagerWallView : UIView
{
    yundaWallCell *wallCell;
}

@end

