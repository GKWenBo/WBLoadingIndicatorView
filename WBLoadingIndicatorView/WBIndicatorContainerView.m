//
//  WBIndicatorContainerView.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/14.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBIndicatorContainerView.h"

@implementation WBIndicatorContainerView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.autoresizesSubviews) {
        return;
    }
    
    if (self.layoutEnd) {
        self.layoutEnd();
    }
}

@end
