#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WBIndicatorContainerView.h"
#import "WBLoadingIndicatorView.h"
#import "WBActivityIndicatorShape.h"
#import "WBAnimationIndicatorBallClipRotate.h"
#import "WBAnimationIndicatorBallClipRotateMultiple.h"
#import "WBAnimationIndicatorBallClipRotatePulse.h"
#import "WBAnimationIndicatorBallPulse.h"
#import "WBAnimationIndicatorBallSurround.h"
#import "WBAnimationIndicatorBallTrianglePath.h"
#import "WBAnimationIndicatorCircleStrokeSpin.h"
#import "WBIndicatorViewProtocol.h"

FOUNDATION_EXPORT double WBLoadingIndicatorViewVersionNumber;
FOUNDATION_EXPORT const unsigned char WBLoadingIndicatorViewVersionString[];

