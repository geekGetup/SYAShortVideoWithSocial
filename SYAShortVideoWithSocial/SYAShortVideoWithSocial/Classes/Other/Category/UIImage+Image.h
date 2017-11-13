//
// UIImage+Image.h
//  聚超值
//
//  Created by 周abel on 16/4/1.
//  Copyright © 2016年 Zhli. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Image)

/** 保护图片不被渲染*/
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

/** 根据颜色生成一张1*1的纯色图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 拉伸图片*/
+ (UIImage *)resizableImageWithImage:(UIImage *) image;

/**
 传入字符串生成二维码
 
 @param str 传入的字符串
 @return 生成的二维码
 */
+ (UIImage *)createCodeImage:(NSString *)str;

+ (NSString *)base64WithImage:(UIImage *)image;

@end
