//
//  WBIndicatorViewProtocol.h
//  Pods-WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WBIndicatorViewProtocol <NSObject>

/**
 显示加载动画
 @param layer 父layer
 @param size 加载动画大小
 @param color 加载动画颜色
 */
- (void)wb_addAnimationWithLayer:(CALayer *)layer
                            size:(CGSize)size
                           color:(UIColor *)color;

@end
