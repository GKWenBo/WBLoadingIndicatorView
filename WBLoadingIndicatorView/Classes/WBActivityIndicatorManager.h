//
//  WBActivityIndicatorManager.h
//  Pods-WBLoadingIndicatorView_Example
//
//  Created by 文波 on 2018/9/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WBLoadingAnimationType) {
    WBLoadingAnimationcircleStrokeSpinType,          /*  < 圆环加载动画 > */
    WBWBLoadingAnimationBallPulseType,               /** < 三并排动画 > */
    WBWBLoadingAnimationBallClipRotateType,
    WBWBLoadingAnimationBallClipRotatePulseType,
    WBWBLoadingAnimationBallClipRotateMultipleType,
    WBWBLoadingAnimationBallTrianglePathType
};

@interface WBActivityIndicatorManager : NSObject

/**
 显示加载动画

 @param layer 父视图layer
 @param type 加载动画类型
 @param size 加载动画大小
 @param color 加载动画颜色
 */
+ (void)wb_showIndicatorAnimationToLayer:(CALayer *)layer
                                    type:(WBLoadingAnimationType)type
                                    size:(CGSize)size
                                   color:(UIColor *)color;

@end
