//
//  WBLoadingIndicatorView.h
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/7.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBLoadingBackgroundView;

typedef NS_ENUM(NSInteger, WBLoadingIndicatorBackgroundStyle) {
    WBLoadingIndicatorBackgroundSolidStyle,
    WBLoadingIndicatorBackgroundBlurStyle
};

typedef NS_ENUM(NSInteger, WBLoadingAnimationType) {
    WBLoadingAnimationcircleStrokeSpin,
    WBLoadingAnimationBallPulse,
    WBLoadingAnimationBallClipRotate,
    WBLoadingAnimationBallClipRotatePulse,
    WBLoadingAnimationBallClipRotateMultiple,
    WBLoadingAnimationBallTrianglePath,
    WBLoadingAnimationBallSurround
};

@interface WBLoadingIndicatorView : UIView

// MARK:Property
/*  < 动画容器视图 > */
@property (nonatomic, strong) WBLoadingBackgroundView *bezelView;
/*  < 背景视图 > */
@property (nonatomic, strong) WBLoadingBackgroundView *backgroundView;
/** < Loading text. > */
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIColor *contentColor UI_APPEARANCE_SELECTOR;
/*  < 加载动画颜色 > */
@property (nonatomic, strong) UIColor *indicatorColor UI_APPEARANCE_SELECTOR;
/*  < bezelView中心点偏移 > */
@property (nonatomic, assign) CGPoint offset UI_APPEARANCE_SELECTOR;
/*  < 边距 默认：20 > */
@property (nonatomic, assign) CGFloat margin UI_APPEARANCE_SELECTOR;
/*  < bezelView最小size > */
@property (nonatomic, assign) CGSize minSize UI_APPEARANCE_SELECTOR;
/** < 加载动画size 默认：35 > */
@property (nonatomic, assign) CGSize indicatorSize UI_APPEARANCE_SELECTOR;
/** < 是否方形 > */
@property (nonatomic, assign) BOOL square UI_APPEARANCE_SELECTOR;
/** < 隐藏时从父视图移除 默认：YES > */
@property (nonatomic, assign) BOOL removeFromSuperViewOnHide;
/*  < 动画类型 默认： WBLoadingAnimationcircleStrokeSpin> */
@property (nonatomic, assign) WBLoadingAnimationType type;

// MARK:Class Methods
/**
 获取视图中的WBLoadingIndicatorView

 @param view 遍历的父视图
 @return WBLoadingIndicatorView
 */
+ (nullable WBLoadingIndicatorView *)wb_indicatorForView:(UIView *)view;

/**
 创建并显示加载视图

 @param view 要显示的view
 @return MBProgressHUD
 */
+ (instancetype)wb_showIndicatorAddTo:(UIView *)view;

// MARK:Instance Class Method
- (instancetype)initWithView:(UIView *)view;

/**
 显示加载视图
 */
- (void)wb_showLoadingView:(BOOL)animated;

/**
 隐藏加载视图

 @param animated 是否动画
 */
- (void)wb_hideLoadingView:(BOOL)animated;

@end

@interface WBLoadingBackgroundView : UIView

/*  < 背景样式 > */
@property (nonatomic, assign) WBLoadingIndicatorBackgroundStyle style;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
/*  < 模糊效果 > */
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;
#endif
/*  < 背景色 > */
@property (nonatomic, strong) UIColor *color;

@end
