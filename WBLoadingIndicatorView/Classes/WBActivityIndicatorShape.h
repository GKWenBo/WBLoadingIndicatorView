//
//  WBActivityIndicatorShape.h
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/7.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WBActivityIndicatorShapeType) {
    WBActivityIndicatorStrokeShapeType,
    WBActivityIndicatorCircleShapeType,
    WBActivityIndicatorRingThirdFourShapeType,
    WBActivityIndicatorRingTwoHalfVerticalShapeType,
    WBActivityIndicatorRingTwoHalfHorizontalShapeType,
    WBActivityIndicatorRingShapeType
};

@interface WBActivityIndicatorShape : NSObject

+ (CALayer *)layerWith:(CGSize)size
                 color:(UIColor *)color
                  type:(WBActivityIndicatorShapeType)type;
@end
