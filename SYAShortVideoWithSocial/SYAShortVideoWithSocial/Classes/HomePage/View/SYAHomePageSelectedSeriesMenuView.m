//
//  SYAHomePageSelectedSeriesMenuView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAHomePageSelectedSeriesMenuView.h"
#import "SYANoHighlightButton.h"
@interface SYAHomePageSelectedSeriesMenuView()
@property (nonatomic, weak) SYANoHighlightButton *preBtn;
@end

@implementation SYAHomePageSelectedSeriesMenuView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    if (self = [super initWithFrame:frame]) {
        CGFloat btnWidth = frame.size.width / titleArray.count;
        for (int i = 0; i<titleArray.count; i++) {
            CGFloat btnX = i*btnWidth;
            NSString *titleStr = titleArray[i];
            SYANoHighlightButton *btn = [SYANoHighlightButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titleStr forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor colorWithRed:154/255.0 green:152/255.0 blue:155/255.0 alpha:1]
                      forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(btnWidth);
                make.left.mas_equalTo(btnX);
            }];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            if (1 == i) {
                self.preBtn = btn;
            }
        }
    }
    [self btnClick:self.preBtn];
    return self;
}

- (void)btnClick:(SYANoHighlightButton *)btn {
    NSInteger index = btn.tag;
    btn.selected = !btn.selected;
    btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:2];
    if (self.preBtn != btn) {
        self.preBtn.selected = NO;
        self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    } else {
        self.preBtn.selected = YES;
    }
    
    self.preBtn = btn;
    if (self.btnClickBlock) {
        self.btnClickBlock(index);
    }
}
@end
