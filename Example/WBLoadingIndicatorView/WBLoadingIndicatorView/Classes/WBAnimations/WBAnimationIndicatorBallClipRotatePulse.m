//
//  WBAnimationIndicatorBallClipRotatePulse.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallClipRotatePulse.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallClipRotatePulse

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CFTimeInterval duration = 1.f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09 :0.57 :0.49 :0.9];
    
    [self smallCircleWith:duration
           timingFunction:timingFunction
                    layer:layer
                     size:size
                    color:color];
    [self bigCircleWith:duration
         timingFunction:timingFunction
                  layer:layer
                   size:size
                  color:color];
}

- (void)smallCircleWith:(CFTimeInterval)duration
         timingFunction:(CAMediaTimingFunction *)timingFunction
                  layer:(CALayer *)layer
                   size:(CGSize)size
                  color:(UIColor *)color {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.keyTimes = @[@0,
                           @0.3,
                           @1];
    animation.duration = duration;
    animation.timingFunctions = @[timingFunction,
                                  timingFunction];
    animation.values = @[@1,
                         @0.3,
                         @1];
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;
    
    CGFloat circleSize = size.width / 2.f;
    CALayer *circle = [WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                    color:color
                                                     type:WBActivityIndicatorCircleShapeType];
    circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

- (void)bigCircleWith:(CFTimeInterval)duration
       timingFunction:(CAMediaTimingFunction *)timingFunction
                layer:(CALayer *)layer
                 size:(CGSize)size
                color:(UIColor *)color {
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0,
                                @0.5,
                                @1];
    scaleAnimation.timingFunctions = @[timingFunction,
                                       timingFunction];
    scaleAnimation.values = @[@1,
                              @0.6,
                              @1];
    scaleAnimation.duration = duration;
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotateAnimation.keyTimes = scaleAnimation.keyTimes;
    rotateAnimation.timingFunctions = @[timingFunction,
                                        timingFunction];
    rotateAnimation.values = @[@0,
                               @(M_PI),
                               @(2 * M_PI)];
    rotateAnimation.duration = duration;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,
                             rotateAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = YES;
    
    CALayer *circle = [WBActivityIndicatorShape layerWith:size
                                                    color:color
                                                     type:WBActivityIndicatorRingTwoHalfVerticalShapeType];
    circle.frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

@end
