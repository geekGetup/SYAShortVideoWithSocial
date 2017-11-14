//
//  SYAGetCurrentViewController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/14.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAGetCurrentViewController.h"

@implementation SYAGetCurrentViewController

+ (UIViewController *)getCurrentVC {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
