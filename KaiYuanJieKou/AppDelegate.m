//
//  AppDelegate.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

/*
 写在前面的话：
    我是ManoBoo，非常感谢您下载我的项目，遇到什么问题可以简书私信给我
    简书地址:
 
 */

#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "SelectAddressController.h"
#import "CityManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [self setInitData];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[WeatherViewController alloc] init] ];
    
    self.window.rootViewController = nav;
    
    
    
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

#pragma mark - Custom

// - MARK: 是否第一次启动，如果是 则配置热门城市列表
- (void)setInitData{
    BOOL isFirstStart;
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:IsFirstStartKey];
    if (obj == nil) {
        isFirstStart = true;
    }else {
        isFirstStart = false;
    }

    if (isFirstStart ) {
        //配置热门城市列表
        [[CityManager shareInstance] setUpHotCityList];
        isFirstStart = false;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isFirstStart] forKey:IsFirstStartKey];
    }
}
@end
