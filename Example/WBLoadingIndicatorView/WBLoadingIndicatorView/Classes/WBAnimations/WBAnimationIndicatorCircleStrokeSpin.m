//
//  WBAnimationIndicatorCircleStrokeSpin.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorCircleStrokeSpin.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorCircleStrokeSpin

- (CALayer *)wb_addAnimationSize:(CGSize)size
                           color:(UIColor *)color {
    CGFloat beginTime = 0.5;
    CGFloat strokeStartDuration = 1.2;
    CGFloat strokeEndDuration = 0.7;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(M_PI * 2);
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = strokeEndDuration;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = strokeStartDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.beginTime = beginTime;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[rotationAnimation,
                                  strokeEndAnimation,
                                  strokeStartAnimation];
    groupAnimation.duration = strokeStartDuration + beginTime;
    groupAnimation.repeatCount = INFINITY;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    CALayer *layer = [WBActivityIndicatorShape layerWith:size
                                                    color:color
                                                     type:WBActivityIndicatorStrokeShapeType];
    [layer addAnimation:groupAnimation
                 forKey:@"animation"];
    return layer;
}

@end
