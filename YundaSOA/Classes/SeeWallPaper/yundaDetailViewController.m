//
//  yundaDetailViewController.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaDetailViewController.h"

@interface yundaDetailViewController ()

@end

@implementation yundaDetailViewController

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
    detailView = [[yundaDetailView alloc] initWithFrame:CGRectMake(100, 130, 800, 500)];
    detailView.backgroundColor = [UIColor grayColor];
    self.view = detailView;
    [self.view bringSubviewToFront:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
