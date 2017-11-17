//
//  SYARecorderFuncationSelectView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYARecorderFuncationSelectView.h"
#import "SYAImageTopTitleBottomButton.h"
@implementation SYARecorderFuncationSelectView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    if (self = [super initWithFrame:frame]) {
        CGFloat btnH = (frame.size.height - (titleArray.count - 1) * 20) / titleArray.count;
        for (int i = 0; i<titleArray.count; i++) {
            NSArray *array = titleArray[i];
            NSString *imageUrl = array.firstObject;
            NSString *title = array.lastObject;
            SYAImageTopTitleBottomButton *btn = [SYAImageTopTitleBottomButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(btnH);
                make.top.mas_equalTo((btnH + 20)*i);
            }];
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:imageUrl] forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)btnClick:(SYAImageTopTitleBottomButton *)btn {
    NSInteger index = btn.tag;
    switch (index) {
        case 0:
        {
            if ([btn.currentTitle isEqualToString:@"美颜开"]) {
                [btn setTitle:@"美颜关" forState:UIControlStateNormal];
                if (self.beautyBtnBlock) {
                    self.beautyBtnBlock(NO);
                }
            } else {
                [btn setTitle:@"美颜开" forState:UIControlStateNormal];
                if (self.beautyBtnBlock) {
                    self.beautyBtnBlock(YES);
                }
            }
        }
            break;
        case 1:
        {
            btn.selected = !btn.selected;
            if (btn.selected) {
                if (self.filterBtnBlock) {
                    self.filterBtnBlock(YES);
                }
            } else {
                if (self.filterBtnBlock) {
                    self.filterBtnBlock(NO);
                }
            }
        }
            break;
        case 2:
        {
            if (self.timeBtnBlock) {
                self.timeBtnBlock();
            }
        }
            break;
        default:
            break;
    }

}
@end
