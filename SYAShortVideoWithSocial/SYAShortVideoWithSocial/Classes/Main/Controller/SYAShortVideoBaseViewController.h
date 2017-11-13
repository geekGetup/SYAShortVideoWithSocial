//
//  SYAShortVideoBaseViewController.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/13.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYAShortVideoBaseViewControllProtocol.h"
@interface SYAShortVideoBaseViewController : UIViewController<SYAShortVideoBaseViewControllProtocol>
/** 回调函数 */
@property (nonatomic, copy) void(^myBlock)(void);
@end
