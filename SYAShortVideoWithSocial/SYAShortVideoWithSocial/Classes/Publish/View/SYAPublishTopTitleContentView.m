//
//  SYAPublishTopTitleContentView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/14.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAPublishTopTitleContentView.h"

@interface SYAPublishTopTitleContentView()

@end

@implementation SYAPublishTopTitleContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *leftUpLoadVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftUpLoadVideoBtn setTitle:@"上传视频" forState:UIControlStateNormal];
        [self addSubview:leftUpLoadVideoBtn];
        leftUpLoadVideoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftUpLoadVideoBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:152/255.0 blue:155/255.0 alpha:1]
                  forState:UIControlStateNormal];
        [leftUpLoadVideoBtn sizeToFit];
        [leftUpLoadVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(leftUpLoadVideoBtn.lj_width);
            make.height.mas_equalTo(frame.size.height);
        }];
        @weakify(self);
        [[leftUpLoadVideoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.btnClickBlock) {
                self.btnClickBlock(0);
            }
        }];
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.text = @"选择音乐";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(titleLabel.lj_width);
            make.height.mas_equalTo(frame.size.height);
        }];
        
        UIButton *rightShotVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightShotVideoBtn setTitle:@"直接开拍" forState:UIControlStateNormal];
        [self addSubview:rightShotVideoBtn];
        rightShotVideoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightShotVideoBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:152/255.0 blue:155/255.0 alpha:1]
                                 forState:UIControlStateNormal];
        [rightShotVideoBtn sizeToFit];
        [rightShotVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(rightShotVideoBtn.lj_width);
            make.height.mas_equalTo(frame.size.height);
        }];
        [[rightShotVideoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.btnClickBlock) {
                self.btnClickBlock(1);
            }
        }];
    }
    return self;
}

@end
