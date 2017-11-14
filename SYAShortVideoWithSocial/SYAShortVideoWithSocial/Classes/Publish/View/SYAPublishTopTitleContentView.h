//
//  SYAPublishTopTitleContentView.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/14.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAPublishTopTitleContentView : UIView
/** 点击按钮 */
@property (nonatomic, copy) void(^btnClickBlock)(NSInteger btnIndex);
@end
