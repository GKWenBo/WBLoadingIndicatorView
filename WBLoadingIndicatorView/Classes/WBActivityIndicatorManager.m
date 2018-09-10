//
//  WBActivityIndicatorManager.m
//  Pods-WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/8.
//

#import "WBActivityIndicatorManager.h"
#import "WBActivityIndicatorShape.h"

@implementation WBActivityIndicatorManager

+ (void)wb_showIndicatorAnimationToLayer:(CALayer *)layer
                                    type:(WBLoadingAnimationType)type
                                    size:(CGSize)size
                                   color:(UIColor *)color {
    switch (type) {
        case WBLoadingAnimationcircleStrokeSpinType:
            [self circleStrokeSpin:layer
                              size:size
                             color:color];
            break;
        case WBWBLoadingAnimationBallPulseType:
            [self ballPulse:layer
                       size:size
                      color:color];
            break;
        case WBWBLoadingAnimationBallClipRotateType:
            [self ballClipRotate:layer
                            size:size
                           color:color];
            break;
        case WBWBLoadingAnimationBallClipRotatePulseType:
            [self ballClipRotatePulse:layer
                                 size:size
                                color:color];
            break;
        case WBWBLoadingAnimationBallClipRotateMultipleType:
            [self ballClipRotateMultiple:layer
                                    size:size
                                   color:color];
            break;
        case WBWBLoadingAnimationBallTrianglePathType:
            [self ballTrianglePath:layer
                              size:size
                             color:color];
            break;
        default:
            break;
    }
}

// MARK:circleStrokeSpin
+ (void)circleStrokeSpin:(CALayer *)layer
                    size:(CGSize)size
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
    
    CALayer *circle = [WBActivityIndicatorShape layerWith:size
                                                    color:color
                                                     type:WBActivityIndicatorStrokeShapeType];
    
    circle.bounds = CGRectMake(0, 0, size.width, size.height);
    circle.position = CGPointMake(size.width / 2.f, size.height / 2.f);
    [circle addAnimation:groupAnimation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

// MARK:ballPulse
+ (void)ballPulse:(CALayer *)layer
             size:(CGSize)size
            color:(UIColor *)color {
    CGFloat circleSpacing = 2.f;
    CGFloat circleSize = (size.width - 2 * circleSpacing) / 3.f;
    CGFloat x = circleSize / 2.f;
    CGFloat y = size.height / 2.f;
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
        circle.bounds = CGRectMake(0, 0, circleSize, circleSize);
        circle.position = CGPointMake(x + i * (circleSize + circleSpacing), y);
        animation.beginTime = beginTime + [beginTimes[i] doubleValue];
        [circle addAnimation:animation
                      forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

// MARK:ballClipRotate
+ (void)ballClipRotate:(CALayer *)layer
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
    circle.bounds = CGRectMake(0, 0, size.width, size.height);
    circle.position = CGPointMake(size.width / 2.f, size.height / 2.f);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

// MARK:ballClipRotatePulse
+ (void)ballClipRotatePulse:(CALayer *)layer
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

+ (void)smallCircleWith:(CFTimeInterval)duration
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
    circle.bounds = CGRectMake(0, 0, circleSize, circleSize);
    circle.position = CGPointMake(size.width / 2.f, size.height / 2.f);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

+ (void)bigCircleWith:(CFTimeInterval)duration
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
    circle.bounds = CGRectMake(0, 0, size.width, size.height);
    circle.position = CGPointMake(size.width / 2.f, size.height / 2.f);
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

// MARK:BallClipRotateMultiple
+ (void)ballClipRotateMultiple:(CALayer *)layer
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
                   size:CGSizeMake(bigCircleSize, bigCircleSize)
                  color:color
                reverse:NO];
    [self circleOfShape:WBActivityIndicatorRingTwoHalfVerticalShapeType
               duration:longDuration
         timingFunction:timingFunction
                  layer:layer
                   size:CGSizeMake(smallCircleSize, smallCircleSize)
                  color:color
                reverse:YES];
}

+ (void)circleOfShape:(WBActivityIndicatorShapeType)shape
             duration:(CFTimeInterval)duration
       timingFunction:(CAMediaTimingFunction *)timingFunction
                layer:(CALayer *)layer
                 size:(CGSize)size
                color:(UIColor *)color
              reverse:(BOOL)reverse {
    CALayer *circle = [WBActivityIndicatorShape layerWith:size
                                                    color:color
                                                     type:shape];
    circle.bounds = CGRectMake(0, 0, size.width, size.height);
    if (shape == WBActivityIndicatorRingTwoHalfVerticalShapeType) {
        circle.position = CGPointMake(size.width, size.height);
    }else {
        circle.position = CGPointMake(size.width / 2.f, size.height / 2.f);
    }
    CAAnimation *animation = [self createAnimationIn:duration
                                      timingFunction:timingFunction
                                             reverse:reverse];
    [circle addAnimation:animation
                  forKey:@"animation"];
    [layer addSublayer:circle];
}

+ (CAAnimation *)createAnimationIn:(CFTimeInterval)duration
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

// MARK:BallTrianglePath
+ (void)ballTrianglePath:(CALayer *)layer
                    size:(CGSize)size
                   color:(UIColor *)color {
    CGFloat circleSize = size.width / 5.f;
    CGFloat deltaX = size.width / 2 - circleSize / 2;
    CGFloat deltaY = size.height / 2 - circleSize / 2;
    CGFloat x = size.width / 2.f;
    CGFloat y = size.height / 2.f;
    CFTimeInterval duration = 2.f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    /** < Animation > */
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.keyTimes = @[@0,
                           @0.33,
                           @0.66,
                           @1];
    animation.timingFunctions = @[timingFunction,
                                  timingFunction,
                                  timingFunction];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;
    
    CALayer *topCenterCircle = [WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                             color:color
    
                                                              type:WBActivityIndicatorRingShapeType];
    // Top-center circle
    [self changeAnimation:animation
                rawValues:@[@"{0,0}",
                            @"{hx,fy}",
                            @"{-hx,fy}",
                            @"{0,0}"]
                   deltaX:deltaX
                   deltaY:deltaX];
    topCenterCircle.bounds = CGRectMake(0, 0, circleSize, circleSize);
    topCenterCircle.position = CGPointMake(size.width / 2.f, circleSize / 2.f);
    [topCenterCircle addAnimation:animation
                           forKey:@"transform"];
    [layer addSublayer:topCenterCircle];
    
    // Bottom-left circle
    CALayer *bottomLeftCircle = [WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                             color:color
                                
                                                              type:WBActivityIndicatorRingShapeType];
    
    [self changeAnimation:animation
                rawValues:@[@"{0,0}",
                            @"{hx,-fy}",
                            @"{fx,0}",
                            @"{0,0}"]
                   deltaX:deltaX
                   deltaY:deltaX];
    bottomLeftCircle.bounds = CGRectMake(0, 0, circleSize, circleSize);
    bottomLeftCircle.position = CGPointMake(circleSize / 2.f, size.height - circleSize / 2.f);
    [bottomLeftCircle addAnimation:animation
                            forKey:@"animation"];
    [layer addSublayer:bottomLeftCircle];
    
    // Bottom-right circle
    CALayer *bottomRightCircle = [WBActivityIndicatorShape layerWith:CGSizeMake(circleSize, circleSize)
                                                              color:color
                                 
                                                               type:WBActivityIndicatorRingShapeType];
    [self changeAnimation:animation
                rawValues:@[@"{0,0}",
                            @"{-fx,0}",
                            @"{-hx,-fy}",
                            @"{0,0}"]
                   deltaX:deltaX
                   deltaY:deltaX];
    bottomRightCircle.bounds = CGRectMake(0, 0, circleSize, circleSize);
    bottomRightCircle.position = CGPointMake(size.width - circleSize / 2.f, size.height - circleSize / 2.f);
    [bottomRightCircle addAnimation:animation
                             forKey:@"animation"];
    [layer addSublayer:bottomRightCircle];
}

+ (void)changeAnimation:(CAKeyframeAnimation *)animation
              rawValues:(NSArray *)rawValues
                 deltaX:(CGFloat)deltaX
                 deltaY:(CGFloat)deltaY {
    NSMutableArray *values = @[].mutableCopy;
    
    for (NSString *rawValue in rawValues) {
        CGPoint point = CGPointFromString([self translateString:rawValue
                                                         deltaX:deltaX
                                                         deltaY:deltaY]);
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(point.x, point.y, 0)]];
    }
    
    animation.values = values;
}

+ (NSString *)translateString:(NSString *)valueString
                       deltaX:(CGFloat)deltaX
                       deltaY:(CGFloat)deltaY {
    NSMutableString *valueMutableString = [[NSMutableString alloc]initWithString:valueString];
    
    CGFloat fullDeltaX = 2 * deltaX;
    CGFloat fullDeltaY = 2 * deltaY;
    NSRange range = NSMakeRange(0, valueMutableString.length);
    
    [valueMutableString replaceOccurrencesOfString:@"hx"
                                        withString:[NSString stringWithFormat:@"%f",deltaX]
                                           options:NSCaseInsensitiveSearch
                                             range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fx"
                                        withString:[NSString stringWithFormat:@"%f",fullDeltaX]
                                           options:NSCaseInsensitiveSearch
                                             range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"hy"
                                        withString:[NSString stringWithFormat:@"%f",deltaY]
                                           options:NSCaseInsensitiveSearch
                                             range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fy"
                                        withString:[NSString stringWithFormat:@"%f",fullDeltaY]
                                           options:NSCaseInsensitiveSearch
                                             range:range];
    return valueMutableString.copy;
}

@end
