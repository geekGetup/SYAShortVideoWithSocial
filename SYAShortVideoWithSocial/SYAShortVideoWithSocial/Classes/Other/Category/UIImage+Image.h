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

/** 根据传入颜色数组生成一张指定大小的颜色渐变图片*/
+ (UIImage *)imageWithColorArray:(NSArray <UIColor *>*)colorArray size:(CGSize)size;
/** 拉伸图片*/
+ (UIImage *)resizableImageWithImage:(UIImage *) image;

/**
 传入字符串生成二维码
 
 @param str 传入的字符串
 @return 生成的二维码
 */
+ (UIImage *)createCodeImage:(NSString *)str;

+ (NSString *)base64WithImage:(UIImage *)image;
/** 传入view,生成这个view的图片*/
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
