//
//  SYARecorderFilterContentView.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYARecordFilterModel.h"
#import "PLSFilterGroup.h"
@interface SYARecorderFilterContentView : UIView
/** 滤镜模型数组 */
@property (nonatomic, strong) NSMutableArray <SYARecordFilterModel *>*filterModelArray;
// 所有滤镜
@property (strong, nonatomic) PLSFilterGroup *filterGroup;
@end
