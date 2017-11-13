//
// UIImage+Image.m
//  聚超值
//
//  Created by 周abel on 16/4/1.
//  Copyright © 2016年 Zhli. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 保护图片不被渲染
+ (UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

// 获取一张 1*1纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 1.0 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 2.0 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 3.0 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 4.0 渲染上下文
    CGContextFillRect(context, rect);
    
    // 5.0 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.0 结束上下文
    UIGraphicsEndImageContext();
    
    // 7.0 返回纯色图片
    return theImage;
}

//  保护图片边角, 拉伸中间部分
+ (UIImage *)resizableImageWithImage:(UIImage *) image {
    
    // 1.0 初始化数据
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 2.0 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 3.0 设置拉伸模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 4.0 返回拉伸后的图片
    return [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
}

+ (UIImage *)createCodeImage:(NSString *)str {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    // 获取输出二维码
    CIImage *outputImage = [filter outputImage];
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    return image;
    
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/// 图片base64编码
+ (NSString *)base64WithImage:(UIImage *)image {
    
    // 获取图片的二进制流
    NSData *data = UIImageJPEGRepresentation(image, 0.6);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    return encodedImageStr;
}
@end