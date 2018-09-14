//
//  WBActivityIndicatorShape.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/7.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBActivityIndicatorShape.h"

@implementation WBActivityIndicatorShape

+ (CALayer *)layerWith:(CGSize)size
                 color:(UIColor *)color
                  type:(WBActivityIndicatorShapeType)type {
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat lineWidth = 2.f;
    
    switch (type) {
        case WBActivityIndicatorStrokeShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:-M_PI / 2.f
                          endAngle:M_PI + M_PI / 2.f
                         clockwise:YES];
            layer.fillColor = nil;
            layer.strokeColor = color.CGColor;
            layer.lineWidth = lineWidth;
        }
            break;
        case WBActivityIndicatorCircleShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:0
                          endAngle:2 * M_PI
                         clockwise:NO];
            layer.fillColor = color.CGColor;
        }
            break;
        case WBActivityIndicatorRingThirdFourShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:-3 * M_PI / 4.f
                          endAngle:- M_PI / 4.f
                         clockwise:NO];
            layer.fillColor = nil;
            layer.lineWidth = lineWidth;
            layer.strokeColor = color.CGColor;
        }
            break;
        case WBActivityIndicatorRingTwoHalfVerticalShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:-3 * M_PI / 4.f
                          endAngle:- M_PI / 4.f
                         clockwise:YES];
            [path moveToPoint:CGPointMake(size.width / 2.f - size.width / 2.f * cos(M_PI / 4.f), size.height / 2.f + size.height / 2.f * sin(M_PI / 4.f))];
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:-5 * M_PI / 4.f
                          endAngle:-7 * M_PI / 4.f
                         clockwise:NO];
            layer.fillColor = nil;
            layer.strokeColor = color.CGColor;
            layer.lineWidth = lineWidth;
        }
            break;
        case WBActivityIndicatorRingTwoHalfHorizontalShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:3 * M_PI / 4.f
                          endAngle:5 * M_PI / 4.f
                         clockwise:YES];
            [path moveToPoint:CGPointMake(size.width / 2.f + size.width / 2.f * cos(M_PI / 4.f), size.height / 2.f - size.height / 2.f * sin(M_PI / 4.f))];
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:-M_PI / 4.f
                          endAngle:M_PI / 4.f
                         clockwise:YES];
            layer.fillColor = nil;
            layer.strokeColor = color.CGColor;
            layer.lineWidth = lineWidth;
        }
            break;
        case WBActivityIndicatorRingShapeType:
        {
            [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f)
                            radius:size.width / 2.f
                        startAngle:0
                          endAngle:2 * M_PI
                         clockwise:NO];
            layer.fillColor = nil;
            layer.lineWidth = lineWidth;
            layer.strokeColor = color.CGColor;
        }
            break;
        default:
            break;
    }
    
    layer.backgroundColor = nil;
    layer.path = path.CGPath;
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    return layer;
}

@end
