//
//  WBIndicatorContainerView.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBIndicatorContainerView.h"
#import "WBAnimationIndicatorCircleStrokeSpin.h"

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
    
    switch (_type) {
        case WBLoadingAnimationcircleStrokeSpin:
        {
            WBAnimationIndicatorCircleStrokeSpin *circleStrokeSpin = [WBAnimationIndicatorCircleStrokeSpin new];
            CALayer *layer = [circleStrokeSpin wb_addAnimationSize:_size
                                                             color:_color];
            layer.frame = CGRectMake((rect.size.width - _size.width) / 2.f, (rect.size.height - _size.height) / 2.f, _size.width, _size.height);
            [self.layer addSublayer:layer];
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
        [self setNeedsDisplay];
    }
}

@end
