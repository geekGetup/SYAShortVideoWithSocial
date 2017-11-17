//
//  SYARecordTopToolContentView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYARecordTopToolContentView.h"

@implementation SYARecordTopToolContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat btnHeight = 30;
        CGFloat topSpace = 20;
        if (AppHeight == 812) {
            topSpace = 44;
        }
        UIView *topRecordToolContentView = [[UIView alloc] init];
        [self addSubview:topRecordToolContentView];
        topRecordToolContentView.backgroundColor = [UIColor clearColor];
        [topRecordToolContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        @weakify(self);
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [topRecordToolContentView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(topRecordToolContentView);
            make.height.mas_equalTo(btnHeight);
            make.width.mas_equalTo(btnHeight);
        }];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"recorderBack"] forState:UIControlStateNormal];
        [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.backBtnBlock) {
                self.backBtnBlock();
            }
        }];
        
        UIButton *nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [topRecordToolContentView addSubview:nextStepBtn];
        [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(topRecordToolContentView);
            make.height.mas_equalTo(btnHeight);
            make.width.mas_equalTo(70);
        }];
        [nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [nextStepBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        nextStepBtn.layer.cornerRadius = 3;
        nextStepBtn.layer.masksToBounds = YES;
        nextStepBtn.enabled = NO;
        [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
        }];
        
        UIButton *switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [topRecordToolContentView addSubview:switchCameraBtn];
        [switchCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(nextStepBtn.mas_left).offset(-30);
            make.centerY.mas_equalTo(topRecordToolContentView);
            make.height.mas_equalTo(btnHeight);
            make.width.mas_equalTo(btnHeight);
        }];
        [switchCameraBtn setBackgroundImage:[UIImage imageNamed:@"SwitchCamera"] forState:UIControlStateNormal];
        [[switchCameraBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.switchCameraBtnBlock) {
                self.switchCameraBtnBlock();
            }
        }];
    }
    return self;
}

@end
