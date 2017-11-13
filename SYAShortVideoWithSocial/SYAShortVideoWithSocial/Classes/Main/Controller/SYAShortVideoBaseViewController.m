//
//  SYAShortVideoBaseViewController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAShortVideoBaseViewController.h"
#import "SYAPublishViewController.h"
@interface SYAShortVideoBaseViewController ()

@end

@implementation SYAShortVideoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    self.myBlock = ^(){
        @strongify(self);
        SYAPublishViewController *vc = [[SYAPublishViewController alloc] init];
        [self presentViewController:vc animated:YES completion:^{
            vc.view.backgroundColor = [UIColor redColor];
        }];
    };
    [self setupBaseUI];
    [self bindBaseViewModel];
}

/**
 *  添加控件
*/
- (void)setupBaseUI {}
/**
 *  绑定ViewModel
*/
- (void)bindBaseViewModel {}
    
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
