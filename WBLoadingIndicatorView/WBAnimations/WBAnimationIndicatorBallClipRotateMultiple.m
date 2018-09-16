//
//  WBAnimationIndicatorBallClipRotateMultiple.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallClipRotateMultiple.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallClipRotateMultiple

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CGFloat bigCircleSize = size.width;
    CGFloat smallCircleSize = size.width / 2.f;
    CFTimeInterval longDuration = 1.f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self circleOfShape:WBActivityIndicatorRingTwoHalfHorizontalShapeType
               duration:longDuration
         timingFunction:timingFunction
                  layer:layer
                   size:bigCircleSize
                  color:color
                reverse:NO];
    [self circleOfShape:WBActivityIndicatorRingTwoHalfVerticalShapeType
               duration:longDuration
         timingFunction:timingFunction
                  layer:layer
                   size:smallCircleSize
                  color:color
                reverse:YES];
}

- (void)circleOfShape:(WBActivityIndicatorShapeType)shape
             duration:(CFTimeInterval)duration
       timingFunction:(CAMediaTimingFunction *)timingFunction
                layer:(CALayer *)layer
                 size:(CGFloat)size
                color:(UIColor *)color
              reverse:(BOOL)reverse {
    CALayer *circle = [WBActivityIndicatorShape layerWith:CGSizeMake(size, size)
                                                    color:color
                                                     type:shape];
    circle.frame = CGRectMake((layer.bounds.size.width - size) / 2, (layer.bounds.size.height - size) / 2, size, size);
    CAAnimation *animation = [self createAnimationIn:duration
                                      timingFunction:timingFunction
                                             reverse:reverse];
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

- (CAAnimation *)createAnimationIn:(CFTimeInterval)duration
                    timingFunction:(CAMediaTimingFunction *)timingFunction
                           reverse:(BOOL)reverse {
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
    if (!reverse) {
        rotateAnimation.values = @[@0,
                                   @M_PI,
                                   @(2 * M_PI)];
    }else {
        rotateAnimation.values = @[@0,
                                   @(-M_PI),
                                   @(- 2 * M_PI)];
    }
    rotateAnimation.duration = duration;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,
                             rotateAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;
    return animation;
}

@end
