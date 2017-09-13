//
//  AppDelegate.m
//  KSYPlayerDemo
//
//  Created by zengfanping on 12/7/15.
//  Copyright © 2015 kingsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "KSYLiveVC.h"

#import <Bugly/Bugly.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

#define DEV_MODE 0
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BuglyConfig *cfg = [[BuglyConfig alloc] init];
    cfg.channel = @"public";
    [Bugly startWithAppId:@"551ed64275" config:cfg];
    NSLog(@"Bugly Version:%@",[Bugly sdkVersion]);
    
    if(!DEV_MODE){
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        KSYLiveVC *liveVc = [[KSYLiveVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:liveVc];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    if (self.settingModel.recording) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
