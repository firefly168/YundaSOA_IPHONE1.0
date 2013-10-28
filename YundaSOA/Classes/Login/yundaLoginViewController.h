//
//  yundaLoginViewController.h
//  YundaSOA
//
//  Created by sam on 13-6-7.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyColor.h"
#import "UIImage+embundle.h"
#import "BaseViewController.h"

@class yundaAppDelegate;
@class yundaMainViewController,LoadingView;

@interface yundaLoginViewController : BaseViewController<UITextFieldDelegate>
{
    BOOL autoLogin;
    BOOL isChecked;
    BOOL isLogined;
    yundaMainViewController *mainpage;
}

@property (nonatomic,assign) BOOL isLogined;
@property (nonatomic,assign) BOOL isChecked;   //是否勾选了记住密码
@property (nonatomic,assign) BOOL autoPwd;     //是否启用64位加密
@property (nonatomic,assign) BOOL autoLogin;   //是否自动登录
@property (weak, nonatomic) IBOutlet UIView *loginMsgView;

@property (strong, nonatomic) IBOutlet UIImageView *LoginBackground;
@property (strong, nonatomic) IBOutlet UIImageView *accountImageView;
@property (strong, nonatomic) IBOutlet UITextField *_username;
@property (strong, nonatomic) IBOutlet UITextField *_password;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwd;
@property (strong, nonatomic) IBOutlet UIButton *_loginButton;
@property (weak, nonatomic) IBOutlet UIButton *resetPwd;
- (IBAction)rememberPwdBtn:(UIButton *)sender;
- (IBAction)doLogin:(UIButton *)sender;
- (IBAction)resetPwdBtn:(UIButton *)sender;

@end

@interface LoadingView : UIView

@property (nonatomic,strong) UIImageView *circleImgView;
@end