//
//  UIView+Extention.m
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "UIView+Extention.h"

@implementation UIView (Extention)

- (CGFloat)czh_top {
    return self.frame.origin.y;
}

- (void)setCzh_top:(CGFloat)czh_top {
    CGRect frame = self.frame;
    frame.origin.y = czh_top;
    self.frame = frame;
}

- (CGFloat)czh_left {
    return self.frame.origin.x;
}

- (void)setCzh_left:(CGFloat)czh_left {
    CGRect frame = self.frame;
    frame.origin.x = czh_left;
    self.frame = frame;
}


- (CGFloat)czh_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setCzh_right:(CGFloat)czh_right {
    self.czh_x = czh_right - self.czh_width;
}


- (CGFloat)czh_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setCzh_bottom:(CGFloat)czh_bottom {
    self.czh_y = czh_bottom - self.czh_height;
}

- (void)setCzh_x:(CGFloat)czh_x {
    CGRect frame = self.frame;
    frame.origin.x = czh_x;
    self.frame = frame;
}

- (void)setCzh_y:(CGFloat)czh_y
{
    CGRect frame = self.frame;
    frame.origin.y = czh_y;
    self.frame = frame;
}

- (CGFloat)czh_x
{
    return self.frame.origin.x;
}

- (CGFloat)czh_y
{
    return self.frame.origin.y;
}

- (void)setCzh_centerX:(CGFloat)czh_centerX
{
    CGPoint center = self.center;
    center.x = czh_centerX;
    self.center = center;
}

- (CGFloat)czh_centerX
{
    return self.center.x;
}

- (void)setCzh_centerY:(CGFloat)czh_centerY
{
    CGPoint center = self.center;
    center.y = czh_centerY;
    self.center = center;
}

- (CGFloat)czh_centerY
{
    return self.center.y;
}

- (void)setCzh_width:(CGFloat)czh_width
{
    CGRect frame = self.frame;
    frame.size.width = czh_width;
    self.frame = frame;
}

- (void)setCzh_height:(CGFloat)czh_height
{
    CGRect frame = self.frame;
    frame.size.height = czh_height;
    self.frame = frame;
}

- (CGFloat)czh_height
{
    return self.frame.size.height;
}

- (CGFloat)czh_width
{
    return self.frame.size.width;
}

- (void)setCzh_size:(CGSize)czh_size
{
    CGRect frame = self.frame;
    frame.size = czh_size;
    self.frame = frame;
}

- (CGSize)czh_size
{
    return self.frame.size;
}

- (void)setCzh_origin:(CGPoint)czh_origin
{
    CGRect frame = self.frame;
    frame.origin = czh_origin;
    self.frame = frame;
}

- (CGPoint)czh_origin
{
    return self.frame.origin;
}


- (instancetype)czh_cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius {
    
    return [self czh_cornerByRoundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius];
}


- (instancetype)czh_cornerByRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    return self;
}


@end
