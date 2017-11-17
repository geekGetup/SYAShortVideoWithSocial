//
//  SYARecorderFuncationSelectView.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYARecorderFuncationSelectView : UIView
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
/** 倒计时block */
@property (nonatomic, copy) void(^timeBtnBlock)(void);
/** 美颜block */
@property (nonatomic, copy) void(^beautyBtnBlock)(BOOL);
/** 滤镜block */
@property (nonatomic, copy) void(^filterBtnBlock)(BOOL);
@end
