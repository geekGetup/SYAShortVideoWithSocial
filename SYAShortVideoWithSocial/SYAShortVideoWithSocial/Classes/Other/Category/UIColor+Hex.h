//
//  UIColor+Hex.h
//  颜色常识
// 描述:输入6位16进制的字符,即可获取对应颜色;
// ff ff ff 01
// r, g, b, Alpha

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
// 默认alpha为1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;
@end
