//
//  SYANavitationController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYANavitationController.h"

@interface SYANavitationController ()

@end

@implementation SYANavitationController

/*
 全屏滑动：
*/
+ (void)load
    {
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    bar.titleTextAttributes = attr;
//    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加Pan,全屏
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    // 不允许边缘手势触发
    self.interactivePopGestureRecognizer.enabled = NO;
    // 实现滑动返回功能
    pan.delegate = self;
}
    
#pragma mark - UIGestureRecognizerDelegate
    // 控制手势是否触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
    {
        // 在根控制器下，就不需要滑动手势，返回NO
        return self.childViewControllers.count > 1;
    }
    
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        // 根控制器不需要设置返回按钮
        
        if (self.childViewControllers.count) { // 非根控制器
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            // 注意:一定要先计算按钮尺寸，在设置contentEdgeInsets
            [backButton sizeToFit];
            // 目的：把按钮往左边挪动
            backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            // 覆盖系统返回按钮
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            viewController.hidesBottomBarWhenPushed = YES;
        }
        // 注意。一定要记得调用super,
        [super pushViewController:viewController animated:animated];
        
    }
    
    // pop
- (void)back
    {
        [self popViewControllerAnimated:YES];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
