//
//  AppDelegate.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "CommodityListViewController.h"
#import "SetTableViewController.h"
#import "BaseTabBarItem.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Crasheye initWithAppKey:@"059063f0"];
    
    // 配置友盟SDK产品并并统一初始化
    [UMConfigure setEncryptEnabled:YES]; // optional: 设置加密传输, 默认NO.
    [UMConfigure initWithAppkey:@"59f471c88f4a9d6474000010" channel:@"App Store"];
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    
    BaseTabBarController * tabbarController = [[BaseTabBarController alloc] init];
    CommodityListViewController * listViewController = [[CommodityListViewController alloc] init];
    BaseTabBarItem * listNavTabBarItem = [[BaseTabBarItem alloc] initWithTitle:@"列表" image:[UIImage imageNamed:@"HomeSource.bundle/1.png"] tag:0];
    listViewController.tabBarItem = listNavTabBarItem;
    UINavigationController * listNav = [[UINavigationController alloc] initWithRootViewController:listViewController];
    
    SetTableViewController * setViewController = [[SetTableViewController alloc] init];
    BaseTabBarItem * setNavTabBarItem = [[BaseTabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"HomeSource.bundle/2.png"] tag:1];
    setViewController.tabBarItem = setNavTabBarItem;
    UINavigationController * setNav = [[UINavigationController alloc] initWithRootViewController:setViewController];
    
    NSArray * navArray = [[NSArray alloc] initWithObjects:listNav,setNav, nil];
    tabbarController.viewControllers = navArray;
    tabbarController.selectedIndex = 0;
    
    
    self.window.rootViewController = tabbarController;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark  ----  处理内容检索的事件
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    return true;
}


@end
