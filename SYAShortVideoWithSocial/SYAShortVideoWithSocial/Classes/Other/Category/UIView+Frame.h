//
//  UIView+Frame.h
//  Copyright © 2016年 xmg. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface UIView (Frame)
@property CGFloat lj_width;
@property CGFloat lj_height;
@property CGFloat lj_x;
@property CGFloat lj_y;
@property CGFloat lj_centerX;
@property CGFloat lj_centerY;
/**
 *  view右边的x值
 */
@property CGFloat lj_maxX;
/**
 *  view底部的y值
 */
@property CGFloat lj_maxY;
@end
