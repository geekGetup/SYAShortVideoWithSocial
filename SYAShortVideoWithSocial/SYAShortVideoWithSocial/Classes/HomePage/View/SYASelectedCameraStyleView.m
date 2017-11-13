//
//  SYASelectedCameraStyleView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYASelectedCameraStyleView.h"

@interface SYASelectedCameraStyleView()
@property (nonatomic, weak) UIButton *preBtn;
@end

@implementation SYASelectedCameraStyleView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)imageNameArray {
    if (self = [super initWithFrame:frame]) {
        CGFloat btnWidth = frame.size.width / imageNameArray.count;
        for (int i = 0; i<imageNameArray.count; i++) {
            CGFloat btnX = i*btnWidth;
            NSString *imageName = imageNameArray[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(btnWidth);
                make.left.mas_equalTo(btnX);
            }];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
    }
    return self;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger index = btn.tag;
    btn.selected = !btn.selected;
    if (self.preBtn != btn) {
        self.preBtn.selected = NO;
    } else {
        self.preBtn.selected = YES;
    }
    self.preBtn = btn;
    if (self.btnClickBlock) {
        self.btnClickBlock(index);
    }
}

@end
