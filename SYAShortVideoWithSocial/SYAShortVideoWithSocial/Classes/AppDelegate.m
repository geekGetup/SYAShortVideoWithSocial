//
//  AppDelegate.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/11.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "AppDelegate.h"
#import <CYLTabBarController/CYLTabBarController.h>
#import "SYANavitationController.h"
#import "SYAHomePageViewController.h"
#import "SYAFoundViewController.h"
#import "SYAPublishViewController.h"
#import "SYAMessageViewController.h"
#import "SYAMineSettingViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self customizeInterface];
    [self setupTabBar];
    return YES;
}

#pragma mark - tabbaritem
- (void)customizeInterface {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:121/255.0 green:149/255.0 blue:187/255.0 alpha:1];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12 weight:2];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"38ADFF"];
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
- (void)setupTabBar {
    SYAHomePageViewController *homePageVC = [[SYAHomePageViewController alloc] init];
    SYANavitationController *homePageNav = [[SYANavitationController alloc] initWithRootViewController:homePageVC];
    
    SYAFoundViewController *foundVC = [[SYAFoundViewController alloc] init];
    SYANavitationController *foundNav = [[SYANavitationController alloc] initWithRootViewController:foundVC];
    
    SYAPublishViewController *publishVC = [[SYAPublishViewController alloc] init];
    SYANavitationController *publishNav = [[SYANavitationController alloc] initWithRootViewController:publishVC];
    
    SYAMessageViewController *messageVC = [[SYAMessageViewController alloc] init];
    SYANavitationController *messageNav = [[SYANavitationController alloc] initWithRootViewController:messageVC];
    
    SYAMineSettingViewController *mineSettingVC = [[SYAMineSettingViewController alloc] init];
    SYANavitationController *mineNav = [[SYANavitationController alloc] initWithRootViewController:mineSettingVC];
    
    CYLTabBarController *tabBarVC = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarVC];
    tabBarVC.delegate = self;
    [tabBarVC setViewControllers:@[
                                   homePageNav,
                                   foundNav,
                                   publishNav,
                                   messageNav,
                                   mineNav
                                   ]];
    [tabBarVC.tabBar setBackgroundImage:[UIImage new]];
    [tabBarVC.tabBar setShadowImage:[UIImage new]];
    [self.window setRootViewController:tabBarVC];
    [self.window makeKeyAndVisible];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == tabBarController.viewControllers[2]) {
        //点击中间tabbarItem，不切换，让当前页面跳转
        SYAPublishViewController *publishVC = [[SYAPublishViewController alloc] init];
        [viewController presentViewController:publishVC animated:YES completion:^{
            
        }];
        return NO;
    }
    return YES;
}

- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    NSDictionary *dictHomePage = @{
                               CYLTabBarItemTitle : @"首页",
                               CYLTabBarItemImage : @"tabbarHomePageSelected",
                               CYLTabBarItemSelectedImage : @"tabbarHomePage",
                               };
    NSDictionary *dictFound = @{
                                CYLTabBarItemTitle : @"发现",
                                CYLTabBarItemImage : @"tabbarFoundSelected",
                                CYLTabBarItemSelectedImage : @"tabbarFound",
                                };
    NSDictionary *dictPublish = @{
                                   CYLTabBarItemTitle : @"发布",
                                   CYLTabBarItemImage : @"tabbarPublishSelected",
                                   CYLTabBarItemSelectedImage : @"tabbarPublish",
                                   };
    NSDictionary *dictMessage = @{
                               CYLTabBarItemTitle : @"消息",
                               CYLTabBarItemImage : @"tabbarMessageSelected",
                               CYLTabBarItemSelectedImage : @"tabbarMessage",
                               };
    NSDictionary *dictMine = @{
                               CYLTabBarItemTitle : @"我的",
                               CYLTabBarItemImage : @"tabbarMineSelected",
                               CYLTabBarItemSelectedImage : @"tabbarMine",
                               };
    NSArray *tabBarItemsAttributes = @[dictHomePage, dictFound, dictPublish,dictMessage,dictMine];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
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


@end
