//
//  yundaSeeWallPaperViewController.m
//  YundaSOA
//
//  Created by sam on 13-6-8.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaSeeWallPaperViewController.h"
#import "UIImage+embundle.h"

@interface yundaSeeWallPaperViewController ()

@end

@implementation yundaSeeWallPaperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    seeWallPaperView = [[yundaSeeWallpaperView alloc] initWithFrame:CGRectZero];
    self.view = seeWallPaperView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
