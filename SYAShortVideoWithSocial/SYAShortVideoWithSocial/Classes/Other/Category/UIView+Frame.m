//
//  UIView+Frame.m
//
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)lj_height
{
    return self.frame.size.height;
}
- (void)setLj_height:(CGFloat)lj_height
{
    CGRect frame = self.frame;
    frame.size.height = lj_height;
    self.frame = frame;
}
- (CGFloat)lj_width
{
    return self.frame.size.width;
}

- (void)setLj_width:(CGFloat)lj_width
{
    CGRect frame = self.frame;
    frame.size.width = lj_width;
    self.frame = frame;
}

- (CGFloat)lj_x
{
    return self.frame.origin.x;
}
- (void)setLj_x:(CGFloat)lj_x
{
    CGRect frame = self.frame;
    frame.origin.x = lj_x;
    self.frame = frame;
}

- (CGFloat)lj_y
{
     return self.frame.origin.y;
}
- (void)setLj_y:(CGFloat)lj_y
{
    CGRect frame = self.frame;
    frame.origin.y = lj_y;
    self.frame = frame;
}

- (void)setLj_centerX:(CGFloat)lj_centerX
{
    CGPoint center = self.center;
    center.x = lj_centerX;
    self.center = center;
}

- (CGFloat)lj_centerX
{
    return self.center.x;
}

- (void)setLj_centerY:(CGFloat)lj_centerY
{
    CGPoint center = self.center;
    center.y = lj_centerY;
    self.center = center;
}

- (CGFloat)lj_centerY
{
    return self.center.y;
}

- (CGFloat)lj_maxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLj_maxX:(CGFloat)lj_maxX {
    CGRect frame = self.frame;
    frame.origin.x = lj_maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lj_maxY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLj_maxY:(CGFloat)lj_maxY {
    CGRect frame = self.frame;
    frame.origin.y = lj_maxY - frame.size.height;
    self.frame = frame;
}
@end
