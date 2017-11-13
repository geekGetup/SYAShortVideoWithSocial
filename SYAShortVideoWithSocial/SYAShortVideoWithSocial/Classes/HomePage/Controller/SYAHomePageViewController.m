//
//  SYAHomePageViewController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAHomePageViewController.h"
#import "SYAHomePageSelectedSeriesMenuView.h"
#import "SYASelectedCameraStyleView.h"
@interface SYAHomePageViewController ()

@end

@implementation SYAHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor]]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)setupBaseUI {
    
    CGFloat screenHeight = AppHeight;
    CGFloat topSpace = 20;
    CGFloat itemWidth = 50;
    if (screenHeight == 812) {
        topSpace = 44;
    }
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    imgView.image = [UIImage imageNamed:@"channelDataBackgroudImage"];
    
    UIView *topMenuContentView = [[UIView alloc] init];
    [self.view addSubview:topMenuContentView];
    [topMenuContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    topMenuContentView.backgroundColor = [UIColor clearColor];
    [self.view layoutIfNeeded];
    
    NSArray *titleArray = @[@"关注",@"推荐",@"附件"];
    CGFloat topSelectedSeriesMenuViewWidth = titleArray.count * itemWidth;
    SYAHomePageSelectedSeriesMenuView *topSelectedSeriesMenuView = [[SYAHomePageSelectedSeriesMenuView alloc] initWithFrame:CGRectMake((topMenuContentView.lj_width - topSelectedSeriesMenuViewWidth)*0.5, 0, topSelectedSeriesMenuViewWidth, topMenuContentView.lj_height) titleArray:titleArray];
    topSelectedSeriesMenuView.backgroundColor = [UIColor clearColor];
    [topMenuContentView addSubview:topSelectedSeriesMenuView];
    
    topSelectedSeriesMenuView.btnClickBlock = ^(NSInteger index){

    };
    
    NSArray *imageNameArray = @[@"navCamera"];
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
