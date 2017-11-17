//
//  SYAImageTopTitleBottomButton.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAImageTopTitleBottomButton.h"

@implementation SYAImageTopTitleBottomButton

- (void)layoutSubviews
{
    // 计算子控件的位置
    [super layoutSubviews];
    self.imageView.lj_x = (self.lj_width - self.imageView.lj_width) * 0.5;
    self.imageView.lj_y = 0;
    // 设置文字宽度 1.计算文字宽度 2.设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.lj_x = (self.lj_width - self.titleLabel.lj_width) * 0.5;
    self.titleLabel.lj_y =  self.lj_height - self.titleLabel.lj_height;
}

@end
