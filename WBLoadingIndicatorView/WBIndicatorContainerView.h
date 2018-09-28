//
//  WBIndicatorContainerView.h
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBIndicatorContainerView : UIView

/*  < 拿到view真实frame，方便布局layer动画 > */
@property (nonatomic, copy) void (^layoutEnd)(void);

@end
