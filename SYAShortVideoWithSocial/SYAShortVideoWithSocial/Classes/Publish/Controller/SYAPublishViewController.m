//
//  SYAPublishViewController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//  滑动view还没有解决

#import "SYAPublishViewController.h"
#import "SYAPublishTopTitleContentView.h"
@interface SYAPublishViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 起始点*/
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIView *effectView;
@property (nonatomic, assign) CGFloat startAlpha;
@end

@implementation SYAPublishViewController
static NSString *cellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.startAlpha = 0.7;
}

- (void)setupBaseUI {
    
    CGFloat topSpace = 20;
    if (AppHeight == 812) {
        topSpace = 44;
    }
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self.view addSubview:backgroundImageView];
    backgroundImageView.image = self.backgroundImage;
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.backgroundImageView = backgroundImageView;
    backgroundImageView.userInteractionEnabled = YES;
    
    UIView *effectView = [[UIView alloc] init];
    [backgroundImageView addSubview:effectView];
    effectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.startAlpha];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.effectView = effectView;
    
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:17/255.0 green:18/255.0 blue:27/255.0 alpha:1];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(AppHeight);
    }];
    
    [self.view layoutIfNeeded];
    
    UIView *topContentView = [[UIView alloc] init];
    [contentView addSubview:topContentView];
    topContentView.frame = CGRectMake(0, topSpace, AppWidth, 164);
    topContentView.backgroundColor = [UIColor clearColor];
    
    SYAPublishTopTitleContentView *topTitleContentView = [[SYAPublishTopTitleContentView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 44)];
    topTitleContentView.backgroundColor = [UIColor clearColor];
    [topContentView addSubview:topTitleContentView];
    
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = CGRectMake(0, CGRectGetMaxY(topTitleContentView.frame), AppWidth, 120);
    tempView.backgroundColor = [UIColor redColor];
    [topContentView addSubview:tempView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [cancelBtn setBackgroundColor:[UIColor colorWithRed:17/255.0 green:18/255.0 blue:27/255.0 alpha:1]];
    @weakify(self);
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    UITableView *songsTableView = [[UITableView alloc] init];
    [contentView addSubview:songsTableView];
    songsTableView.dataSource = self;
    songsTableView.delegate = self;
    songsTableView.bounces = YES;
    songsTableView.backgroundColor = [UIColor colorWithRed:17/255.0 green:18/255.0 blue:27/255.0 alpha:1];
    [songsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [songsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topContentView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(cancelBtn.mas_top);
    }];

    
}

#pragma mark - 数据源方法和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu%@",indexPath.row,@"我回"];
    cell.backgroundColor = [UIColor colorWithRed:17/255.0 green:18/255.0 blue:27/255.0 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    LJLog(@"+++++++++%f",scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y < 0) {
//        self.contentView.frame = CGRectMake(0, -scrollView.contentOffset.y, AppWidth, AppHeight);
//    }
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    self.startPoint = point;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    CGFloat space = point.y - self.startPoint.y;
    if (space > 0) {
        self.startAlpha = 0.7 - 0.7 * space / AppHeight;
        self.effectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.startAlpha];
        self.contentView.frame = CGRectMake(0, space, AppWidth, AppHeight);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    CGFloat endSpace = point.y - self.startPoint.y;
    if (endSpace > 0.5*AppHeight) {
        [UIView animateWithDuration:0.5 animations:^{
            self.contentView.frame = CGRectMake(0, AppHeight, AppWidth, AppHeight);
        } completion:^(BOOL finished) {
            self.contentView.hidden = YES;
            [self dismissViewControllerAnimated:NO completion:^{

            }];
        }];

    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.contentView.frame = CGRectMake(0, 0, AppWidth, AppHeight);
        }];
        self.effectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
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
