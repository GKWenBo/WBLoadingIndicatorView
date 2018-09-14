//
//  WBIndicatorContainerView.h
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBLoadingIndicatorView.h"

@interface WBIndicatorContainerView : UIView


@property (nonatomic, assign) WBLoadingAnimationType type;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIColor *color;


/**
 便利构造方法

 @param type 动画类型
 @param size 动画内容大小
 @param color 动画颜色
 @return WBIndicatorContainerView
 */
+ (instancetype)wb_animationViewWithType:(WBLoadingAnimationType)type
                                    size:(CGSize)size
                                   color:(UIColor *)color;


/**
 实例化方法

 @param type 动画类型
 @param size 动画内容大小
 @param color 动画颜色
 @return WBIndicatorContainerView
 */
- (instancetype)initWithType:(WBLoadingAnimationType)type
                        size:(CGSize)size
                       color:(UIColor *)color;

@end
