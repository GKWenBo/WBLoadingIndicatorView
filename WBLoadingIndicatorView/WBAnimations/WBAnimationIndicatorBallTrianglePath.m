//
//  WBAnimationIndicatorBallTrianglePath.m
//  WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/15.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBAnimationIndicatorBallTrianglePath.h"
#import "WBActivityIndicatorShape.h"

@implementation WBAnimationIndicatorBallTrianglePath

- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color {
    CGFloat circleSize = size.width / 5.f;
    CGFloat deltaX = size.width / 2 - circleSize / 2;
    CGFloat deltaY = size.height / 2 - circleSize / 2;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
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
    topCenterCircle.frame = CGRectMake(x + size.width / 2 - circleSize / 2, y, circleSize, circleSize);
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
                   deltaY:deltaY];
    bottomLeftCircle.frame = CGRectMake(x, y + size.height - circleSize, circleSize, circleSize);
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
    bottomRightCircle.frame = CGRectMake(x + size.width - circleSize, y + size.height - circleSize, circleSize, circleSize);
    [bottomRightCircle addAnimation:animation
                             forKey:@"animation"];
    [layer addSublayer:bottomRightCircle];
}

- (void)changeAnimation:(CAKeyframeAnimation *)animation
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

- (NSString *)translateString:(NSString *)valueString
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
