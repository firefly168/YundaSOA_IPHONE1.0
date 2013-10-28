//
//  BaseViewController.m
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "BaseViewController.h"
#import "WindowControl.h"
#import "MessageCenter.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    [self ViewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {

    [[WindowControl getInstance] setCurrentWindow:self];
    [self ViewWillDisappear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {

    [[WindowControl getInstance] setCurrentWindow:nil];
    [self ViewWillDisappear:animated];
}

- (void) onTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info {
    [self OnTrigger:iTriggerID byTriggerInfo:info];
}

- (void)ViewDidLoad {

}

- (void)DidReceiveMemoryWarning {

}

- (void) ViewWillAppear:(BOOL)animated {
    
}

- (void) ViewWillDisappear:(BOOL)animated {
    
}

- (void) OnTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info {

}

- (void) winForwardTo:(Class)targetWin {
    [[WindowControl getInstance] winForwardTo:targetWin];
}

- (void) switchRootController:(Class)targetWin {
    [[WindowControl getInstance] switchRootController:targetWin];
}
@end
