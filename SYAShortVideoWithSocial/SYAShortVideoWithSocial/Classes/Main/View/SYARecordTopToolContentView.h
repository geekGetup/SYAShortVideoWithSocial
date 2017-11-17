//
//  SYARecordTopToolContentView.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYARecordTopToolContentView : UIView
/** 返回按钮block */
@property (nonatomic, copy) void(^backBtnBlock)(void);
/** 切换摄像头 */
@property (nonatomic, copy) void(^switchCameraBtnBlock)(void);
/** 下一步 */
@property (nonatomic, copy) void(^nextStepBtnBlock)(void);
@end
