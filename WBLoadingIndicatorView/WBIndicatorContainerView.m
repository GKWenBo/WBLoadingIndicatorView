//
//  WBIndicatorContainerView.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBIndicatorContainerView.h"
#import "WBAnimationIndicatorCircleStrokeSpin.h"
#import "WBAnimationIndicatorBallPulse.h"
#import "WBAnimationIndicatorBallClipRotate.h"
#import "WBAnimationIndicatorBallClipRotatePulse.h"
#import "WBAnimationIndicatorBallClipRotateMultiple.h"
#import "WBAnimationIndicatorBallTrianglePath.h"
#import "WBAnimationIndicatorBallSurround.h"

@implementation WBIndicatorContainerView

+ (instancetype)wb_animationViewWithType:(WBLoadingAnimationType)type
                                    size:(CGSize)size
                                   color:(UIColor *)color {
    return [[self alloc]initWithType:type
                                size:size
                               color:color];
}

- (instancetype)initWithType:(WBLoadingAnimationType)type
                        size:(CGSize)size
                       color:(UIColor *)color {
    if (self = [super init]) {
        _type = type;
        _size = size;
        _color = color;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.layer removeAllAnimations];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.layer.sublayers = nil;
    self.layer.speed = 1.f;
    
    switch (_type) {
        case WBLoadingAnimationcircleStrokeSpin:
        {
            WBAnimationIndicatorCircleStrokeSpin *circleStrokeSpin = [WBAnimationIndicatorCircleStrokeSpin new];
            [circleStrokeSpin wb_addAnimationWithLayer:self.layer
                                                  size:_size
                                                 color:_color];
        }
            break;
        case WBLoadingAnimationBallPulse:
        {
            WBAnimationIndicatorBallPulse *ballPulse = [WBAnimationIndicatorBallPulse new];
            [ballPulse wb_addAnimationWithLayer:self.layer
                                           size:_size
                                          color:_color];
        }
            break;
        case WBLoadingAnimationBallClipRotate:
        {
            WBAnimationIndicatorBallClipRotate *ballClipRotate = [WBAnimationIndicatorBallClipRotate new];
            [ballClipRotate wb_addAnimationWithLayer:self.layer
                                                size:_size
                                               color:_color];
        }
            break;
        case WBLoadingAnimationBallClipRotatePulse:
        {
            WBAnimationIndicatorBallClipRotatePulse *ballClipRotatePulse = [WBAnimationIndicatorBallClipRotatePulse new];
            [ballClipRotatePulse wb_addAnimationWithLayer:self.layer
                                                     size:_size
                                                    color:_color];
        }
            break;
        case WBLoadingAnimationBallClipRotateMultiple:
        {
            WBAnimationIndicatorBallClipRotateMultiple *ballClipRotateMultiple = [WBAnimationIndicatorBallClipRotateMultiple new];
            [ballClipRotateMultiple wb_addAnimationWithLayer:self.layer
                                                        size:_size
                                                       color:_color];
        }
            break;
        case WBLoadingAnimationBallTrianglePath:
        {
            WBAnimationIndicatorBallTrianglePath *ballTrianglePath = [WBAnimationIndicatorBallTrianglePath new];
            [ballTrianglePath wb_addAnimationWithLayer:self.layer
                                                  size:_size
                                                 color:_color];
        }
            break;
        case WBLoadingAnimationBallSurround:
        {
            WBAnimationIndicatorBallSurround *ballSurround = [WBAnimationIndicatorBallSurround new];
            [ballSurround wb_addAnimationWithLayer:self.layer
                                              size:_size
                                             color:_color];
            
        }
            break;
        default:
            break;
    }
}

// MARK:Setter
- (void)setSize:(CGSize)size {
    if (!CGSizeEqualToSize(size, _size)) {
        _size = size;
        [self setNeedsDisplay];
    }
}

- (void)setColor:(UIColor *)color {
    if (color != _color && ![color isEqual:_color]) {
        _color = color;
        [self setNeedsDisplay];
    }
}

- (void)setType:(WBLoadingAnimationType)type {
    if (type != _type) {
        _type = type;
        [self setNeedsDisplay];
    }
}

@end
