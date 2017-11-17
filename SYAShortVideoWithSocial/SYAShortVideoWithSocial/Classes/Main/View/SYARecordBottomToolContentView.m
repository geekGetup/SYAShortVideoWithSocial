//
//  SYARecordBottomToolContentView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYARecordBottomToolContentView.h"
#import "SYANoHighlightButton.h"
@interface SYARecordBottomToolContentView()
@property (nonatomic, weak) SYANoHighlightButton *multiplePreBtn;
@end

@implementation SYARecordBottomToolContentView

- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat leftSpace = 40;
    CGFloat btnHeight = 30;
    CGFloat btnWidth = (AppWidth - 2*40)*0.2;
    UIColor *commonWhiteColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    CGFloat topSpace = 20;
    if (AppHeight == 812) {
        topSpace = 44;
    }
    if (self = [super initWithFrame:frame]) {
        UIView *bottomRecordToolContentView = [[UIView alloc] init];
        [self addSubview:bottomRecordToolContentView];
        bottomRecordToolContentView.backgroundColor = [UIColor clearColor];
        [bottomRecordToolContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(140);
        }];
        
        NSArray *titleArray = @[@"极慢",@"慢",@"标准",@"快",@"极快"];
        UIView *multipleRecordBtnContentView = [[UIView alloc] init];
        multipleRecordBtnContentView.backgroundColor = [UIColor colorWithRed:17/255.0 green:18/255.0 blue:27/255.0 alpha:0.7];
        [bottomRecordToolContentView addSubview:multipleRecordBtnContentView];
        [multipleRecordBtnContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(leftSpace);
            make.right.mas_equalTo(-leftSpace);
            make.height.mas_equalTo(btnHeight);
        }];
        multipleRecordBtnContentView.layer.cornerRadius = 3;
        multipleRecordBtnContentView.layer.masksToBounds = YES;
        for (int i = 0; i<titleArray.count; i++) {
            NSString *titleStr = titleArray[i];
            SYANoHighlightButton *multipleBtn = [SYANoHighlightButton buttonWithType:UIButtonTypeCustom];
            [multipleRecordBtnContentView addSubview:multipleBtn];
            [multipleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(i*btnWidth);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(btnWidth);
            }];
            [multipleBtn setTitle:titleStr forState:UIControlStateNormal];
            [multipleBtn setTitleColor:commonWhiteColor forState:UIControlStateNormal];
            [multipleBtn setTitleColor:themeBlackColor forState:UIControlStateSelected];
            multipleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [multipleBtn setBackgroundImage:[UIImage imageWithColor:commonWhiteColor] forState:UIControlStateSelected];
            multipleBtn.tag = i;
            [multipleBtn addTarget:self action:@selector(multipleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            multipleBtn.layer.cornerRadius = 3;
            multipleBtn.layer.masksToBounds = YES;
            if (2 == i) {
                [self multipleBtnClick:multipleBtn];
            }
        }
        
        UIButton *startRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomRecordToolContentView addSubview:startRecordBtn];
        [startRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(multipleRecordBtnContentView.mas_bottom).offset(10);
            make.centerX.mas_equalTo(bottomRecordToolContentView);
            make.width.height.mas_equalTo(60);
        }];
        UIImage *backimg = [UIImage imageWithColorArray:@[[UIColor colorWithRed:235/255.0 green:0 blue:116/255.0 alpha:1],[UIColor colorWithRed:250/255.0 green:33/255.0 blue:80/255.0 alpha:1]] size:CGSizeMake(60, 60)];
        startRecordBtn.layer.cornerRadius = 30;
        startRecordBtn.layer.masksToBounds = YES;
        [startRecordBtn setBackgroundImage:backimg forState:UIControlStateNormal];
    }
    return self;
}

- (void)multipleBtnClick:(SYANoHighlightButton *)btn {
    NSInteger index = btn.tag;
    btn.selected = !btn.selected;
    if (self.multiplePreBtn != btn) {
        self.multiplePreBtn.selected = NO;
    } else {
        self.multiplePreBtn.selected = YES;
    }
    
    self.multiplePreBtn = btn;
}

@end
