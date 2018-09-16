//
//  WBAnimationIndicatorBallPulse.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallPulse.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallPulse

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CGFloat circleSpacing = 2.f;
    CGFloat circleSize = (size.width - 2 * circleSpacing) / 3.f;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    CFTimeInterval duration = 0.75f;
    CFTimeInterval beginTime = CACurrentMediaTime();
    NSArray *beginTimes = @[@0.12,
                            @0.24,
                            @0.36];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.68 :0.18 :1.08];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[@0,@0.3,@1];
    animation.timingFunctions = @[timingFunction,
                                  timingFunction];
    animation.values = @[@1,
                         @0.3,
                         @1];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;

    for (NSInteger i = 0; i < 3; i ++) {
        CALayer *circle = [WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                        color:color
                                                         type:WBActivityIndicatorCircleShapeType];
        circle.frame = CGRectMake(x + i * (circleSize + circleSpacing), y, circleSize, circleSize);
        animation.beginTime = beginTime + [beginTimes[i] doubleValue];
        [circle addAnimation:animation
                      forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

@end
