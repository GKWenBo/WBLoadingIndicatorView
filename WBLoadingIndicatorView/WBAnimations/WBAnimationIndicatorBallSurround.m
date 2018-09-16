//
//  WBAnimationIndicatorBallSurround.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallSurround.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallSurround

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CGFloat circleSpacing = size.width / 5.f ;
    CGFloat circleSize = circleSpacing;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    CGFloat moveY = circleSpacing;
    CFTimeInterval duration = 1.5f;
    
    UIColor *color1 = [color colorWithAlphaComponent:1.f];
    UIColor *color2 = [color colorWithAlphaComponent:0.6f];
    UIColor *color3 = [color colorWithAlphaComponent:0.6f];
    
    CAShapeLayer *circle1 = (CAShapeLayer *)[WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                                          color:color1
                                                                           type:WBActivityIndicatorCircleShapeType];
    circle1.frame = CGRectMake(x, y - moveY, circleSize, circleSize);
    [layer addSublayer:circle1];
    
    
    CAShapeLayer *circle2 = (CAShapeLayer *)[WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                                          color:color2
                                                                           type:WBActivityIndicatorCircleShapeType];
    circle2.frame = CGRectMake(x + circleSize + circleSpacing, y, circleSize, circleSize);
    [layer addSublayer:circle2];
    
    
    CAShapeLayer *circle3 = (CAShapeLayer *)[WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                                          color:color3
                                                                           type:WBActivityIndicatorCircleShapeType];
    circle3.frame = CGRectMake(x + 2 * circleSize + 2 * circleSpacing, y + moveY, circleSize, circleSize);
    [layer addSublayer:circle3];
    
    
    CGPoint point1 = CGPointMake(circleSize / 2.f + moveY + x, y + circleSpacing / 2.f);
    CGPoint point2 = CGPointMake(circleSize / 2.f + circleSpacing + circleSize + moveY + x, y + circleSpacing / 2.f);
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:point1
                     radius:moveY
                 startAngle:-M_PI
                   endAngle:0
                  clockwise:YES];
    UIBezierPath *path1_1 = [UIBezierPath bezierPath];
    [path1_1 addArcWithCenter:point2
                       radius:moveY
                   startAngle:-M_PI
                     endAngle:0
                    clockwise:NO];
    [path1 appendPath:path1_1];
    [self wb_viewMovePathAnimWith:circle1
                             path:path1
                          andTime:duration];
    [self viewColorAnimWith:circle1
                  fromColor:color1
                    toColor:color3
                    andTime:duration];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:point1
                     radius:moveY
                 startAngle:0
                   endAngle:-M_PI
                  clockwise:YES];
    [self wb_viewMovePathAnimWith:circle2
                             path:path2
                          andTime:duration];
    [self viewColorAnimWith:circle2
                  fromColor:color2
                    toColor:color1
                    andTime:duration];

    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:point2
                     radius:moveY
                 startAngle:0
                   endAngle:-M_PI
                  clockwise:NO];
    [self wb_viewMovePathAnimWith:circle3
                             path:path3
                          andTime:duration];
    [self viewColorAnimWith:circle3
                  fromColor:color3
                    toColor:color1
                    andTime:duration];
}

- (void)viewColorAnimWith:(CAShapeLayer *)layer
                fromColor:(UIColor *)fromColor
                  toColor:(UIColor *)toColor
                  andTime:(CGFloat)time {
    CABasicAnimation *colorAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    colorAnim.toValue = (__bridge id _Nullable)([toColor CGColor]);
    colorAnim.fromValue = (__bridge id _Nullable)([fromColor CGColor]);
    colorAnim.duration = time;
    colorAnim.autoreverses = NO;
    colorAnim.fillMode = kCAFillModeForwards;
    colorAnim.removedOnCompletion = NO;
    colorAnim.repeatCount = HUGE;
    [layer addAnimation:colorAnim
                 forKey:@"fillColor"];
}

- (void)wb_viewMovePathAnimWith:(CALayer *)layer
                           path:(UIBezierPath *)path
                        andTime:(CGFloat)time {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = [path CGPath];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubic;
    animation.repeatCount = HUGE;
    animation.duration = time;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation
                 forKey:@"animation"];
}

@end
