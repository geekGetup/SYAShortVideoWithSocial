//
//  SYARecordFilterModel.h
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYARecordFilterModel : NSObject
/** 图片名 */
@property (nonatomic, strong) NSString *imageName;
/** 滤镜名 */
@property (nonatomic, strong) NSString *filterName;
/** 是否被选中*/
@property (nonatomic, assign) BOOL isSelected;
@end
