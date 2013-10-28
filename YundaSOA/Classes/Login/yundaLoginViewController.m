//
//  yundaLoginViewController.m
//  YundaSOA
//
//  Created by sam on 13-6-7.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaLoginViewController.h"
#import "yundaAppDelegate.h"
#import "HttpCaller.h"
#import "UserBeanReq.h"
#import "CommonUtil.h"
#import "UserBeanRes.h"
#import "SPController.h"
#import "MMProgressHUD.h"
#import "Constants.h"

@interface yundaLoginViewController ()
{
    UserBeanReq *req;
    LoadingView *loadingView;
    NSString *userIDStr;
    NSString *passwordStr;
}

@property (nonatomic,strong) NSTimer *_activeTimer;
@property (nonatomic,assign) int reqID;

@end

@implementation yundaLoginViewController
@synthesize reqID,_activeTimer,_password,_username,isChecked,isLogined,autoLogin,autoPwd;

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
    autoLogin = NO;
    isLogined = NO;
    autoPwd = YES;
    isChecked = NO;
    self._username.delegate = self;
    self._password.delegate = self;
    
    [self getUserMessage];
    [self.rememberPwd setBackgroundImage:[UIImage imageNamed:(isChecked?@"checked.png":@"unchecked.png")] forState:UIControlStateNormal];
    
    //autoLogin为yes则自动登录
    if (autoLogin) {
        self._username.text = userIDStr;
        self._password.text = passwordStr;
        [self doLogin:nil];
    }
    
    //点击隐藏键盘按钮所触发的事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)loadView
{
    [super loadView];
    
    [self showLoginAnimation];
    
    if (req == nil) {
        req = [[UserBeanReq alloc] init];
    }
}

- (void)showLoginAnimation
{
    CGRect upFrame = self.accountImageView.frame;
    upFrame.origin.y = -200;
    self.accountImageView.frame = upFrame;
    
    CGRect downFrame = self.loginMsgView.frame;
    downFrame.origin.y = 500;
    self.loginMsgView.frame = downFrame;
    
    upFrame.origin.y = 40;
    downFrame.origin.y = 200;
    NSTimeInterval animationDuration = 1.10f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.accountImageView.frame = upFrame;
    self.loginMsgView.frame = downFrame;
    [UIView commitAnimations];
}

- (void)handleRotateShowTimer:(NSTimer *)sender
{
#if STOP_TIMER
    if (!self.isLogined)
#else
        if (0)
#endif
        {
            //旋转
            static CGFloat radian = 150 * (M_2_PI / 360);
            CGAffineTransform transformTmp = loadingView.circleImgView.transform;
            transformTmp = CGAffineTransformRotate(transformTmp, radian);
            loadingView.circleImgView.transform = transformTmp;
        } else {
#if STOP_TIMER
            [sender invalidate];
            sender = nil;
            [loadingView removeFromSuperview];
            loadingView = nil;

            //代码实现storyboard切换
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            mainpage = [storyboard instantiateViewControllerWithIdentifier:@"mainpage"];
            [self.navigationController pushViewController:mainpage animated:YES];
#endif
        }
}

- (void)showLoadingViewandTimer:userID Password:password
{
    if (loadingView == nil) {
        loadingView = [[LoadingView alloc] init];
    }
    loadingView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self.view addSubview:loadingView];
    
    if (_activeTimer) {
        [_activeTimer invalidate];
        _activeTimer = nil;
    }
    
    //实现一个每隔固定的时间便会重复执行的计时器，直到关闭它
    _activeTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                    target:self
                                                  selector:@selector(handleRotateShowTimer:)
                                                  userInfo:nil
                                                   repeats:YES];
    NSRunLoop * main=[NSRunLoop currentRunLoop];
    [main addTimer:_activeTimer forMode:NSRunLoopCommonModes];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"登录中..." status:@"请稍候"];
    
    //发送帐号登录信息到服务器
    [req setUserId:userID]; //@"90000001"
    [req setPwd:password]; //@"000000a"
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_LOGIN setObj:req];
}

- (void) OnTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info
{
    if (iTriggerID == TRIGGER_ID_RESPONSE) {
        ResponseBean *res;
        @try {
            res = [CommonUtil checkResBean:[info getObjParam] reqID:reqID moduleID:nil delegate:self message:@"登录失败"];
            //返回res表示获取登录信息失败
            if (res == nil) {
#if STOP_TIMER
                self._password.text = @"";
                self.autoPwd = NO;
                if (_activeTimer) {
                    [_activeTimer invalidate];
                    _activeTimer = nil;
                }
                [loadingView removeFromSuperview];
                loadingView = nil;
                
                double delayInSeconds = 0.1;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MMProgressHUD dismissWithSuccess:@""];
                });
#endif
                
                return;
            }
        }
        @catch (NSException *exception) {
            return;
        }
        @finally {

        }
        [CommonUtil setLoginUser:[(UserBeanRes *)res user]];
        [CommonUtil setAutoLogin:isChecked password:self._password.text];
        YundaLog(@"username = %@",[[(UserBeanRes *)res user] userName]);
        //设置成功登录标志
        [self performSelector:@selector(setSuccessLoginFlag) withObject:nil afterDelay:1.0];
    }
}

- (void)setSuccessLoginFlag
{
    self.isLogined = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLoginBackground:nil];
    [self setAccountImageView:nil];
    [self set_username:nil];
    [self set_password:nil];
    [self set_loginButton:nil];
    [self setLoginMsgView:nil];
    [super viewDidUnload];
}

//获取用户登录信息
- (void)getUserMessage
{
    autoLogin = [[SPController getInstance] getBooleanValue:AUTO_LOGIN defValue:NO];
    passwordStr = [[SPController getInstance] getValue:AUTO_LOGIN_PWD defValue:@""];
    userIDStr = [[SPController getInstance] getValue:AUTO_LOGIN_USERID defValue:@""];
    if (autoLogin) {
        isChecked = YES;
    }
}

- (IBAction)rememberPwdBtn:(UIButton *)sender {
    isChecked = !isChecked;
    if (isChecked) {
        [self.rememberPwd setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    } else {
        [self.rememberPwd setBackgroundImage:[[UIImage imageNamed:@"unchecked.png"] stretchableImageWithLeftCapWidth:4.0f topCapHeight:4.0f] forState:UIControlStateNormal];
        [self.rememberPwd setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)doLogin:(UIButton *)sender {
    
#if !STOP_TIMER
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    mainpage = [storyboard instantiateViewControllerWithIdentifier:@"mainpage"];
    [self.navigationController pushViewController:mainpage animated:YES];
    return;
#endif
    
    if (self._username.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入登录帐号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else if (self._username.text.length < 8) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的帐号位数太短，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else if (self._password.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    self._password.text = ((autoLogin && autoPwd)?self._password.text:[CommonUtil encodeBase64:self._password.text]);
    [self showLoadingViewandTimer:self._username.text Password:self._password.text];

}

- (IBAction)resetPwdBtn:(UIButton *)sender {
    [self._username setText:@""];
    [self._password setText:@""];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 10 && textField.text.length > 11) {
        return NO;
    } else if (textField.tag == 11 && textField.text.length > 8){
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    frame.origin.y = -66;
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    NSTimeInterval animationDuration = 0.30f;
    //self.view移回原位置
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self keyboardWillHide:nil];
    [self._username resignFirstResponder];
    [self._password resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyboardWillHide:nil];
    [self._username resignFirstResponder];
    [self._password resignFirstResponder];
    return NO;
}

@end

@implementation LoadingView
@synthesize circleImgView;

- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat loading_Width = 100;
    CGFloat loading_Height = 100;
    
    UIView *bgview = [[UIView alloc] init];
    bgview.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    bgview.backgroundColor = [UIColor grayColor];
    bgview.alpha = 0.2;
    [self addSubview:bgview];
    
    UIView *bgCircleview = [[UIView alloc] init];
    bgCircleview.frame = CGRectMake((self.frame.size.width - loading_Width)/2, (self.frame.size.height - loading_Height)/2, loading_Width, loading_Height);
    bgCircleview.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgCircleview];
    
    UIImageView *bgLoadingImgView = [[UIImageView alloc] init];
    bgLoadingImgView.frame = CGRectMake(0, 0, loading_Width, loading_Height);
    [bgLoadingImgView setImage:[UIImage imageNamed:@"yunda_logo_coordinate.png"]];
    [bgCircleview addSubview:bgLoadingImgView];
    
    if (circleImgView == nil) {
        circleImgView = [[UIImageView alloc] init];
    }
    circleImgView.frame = bgLoadingImgView.frame;
    [circleImgView setImage:[UIImage imageNamed:@"yunda_logo_circle.png"]];
    [bgCircleview addSubview:circleImgView];
}

@end