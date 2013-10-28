//
//  yundaAppDelegate.m
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaAppDelegate.h"
#import "HttpRequestHandler.h"

static HttpRequestHandler *handler;

@implementation yundaWindow

-(void)sendEvent:(UIEvent *)event
{
	[super sendEvent:event];
	UITouch* touch=[[event allTouches] anyObject];
	if(touch.phase==UITouchPhaseBegan){
        //重启计数器
//        if(mainController)
//        {
//            [mainController stopTimer];
//            [mainController startTimer];
//        }
	}
}

@end

@implementation yundaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    theDelegate = self;
//    CGRect rect = [[UIScreen mainScreen] bounds];
    
//    loginController = [[yundaLoginViewController alloc] init];
//    _window = [[yundaWindow alloc] initWithFrame:rect];
//    _window.rootViewController = loginController;
//    [_window makeKeyAndVisible];
    
    //针对ios7或以下进行的适配动作
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//        // Load resources for iOS 6.1 or earlier
//    } else {
//        // Load resources for iOS 7 or later
//    }
    
    handler = [[HttpRequestHandler alloc] init];
    [CommonUtil setVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
