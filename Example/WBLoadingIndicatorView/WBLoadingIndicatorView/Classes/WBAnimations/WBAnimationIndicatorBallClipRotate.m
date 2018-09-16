//
//  WBWBLoadingAnimationBallClipRotateType.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallClipRotate.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallClipRotate

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CFTimeInterval duration = 0.75f;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.keyTimes = @[@0,
                                @0.5,
                                @1];
    scaleAnimation.values = @[@1,
                              @0.6,
                              @1];
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.keyTimes = scaleAnimation.keyTimes;
    rotateAnimation.values = @[@0,
                               @(M_PI),
                               @(M_PI * 2)];
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,
                             rotateAnimation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;
    
    CALayer *circle = [WBActivityIndicatorShape layerWith:size
                                                    color:color
                                                     type:WBActivityIndicatorRingThirdFourShapeType];
    CGRect rect = layer.bounds;
    circle.frame = CGRectMake((rect.size.width - size.width) / 2,  (rect.size.height - size.height) / 2, size.width, size.height);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

@end
