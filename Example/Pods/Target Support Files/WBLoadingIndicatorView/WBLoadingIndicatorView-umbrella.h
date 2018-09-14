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

#import "WBActivityIndicatorShape.h"
#import "WBAnimationIndicatorBaseView.h"
#import "WBAnimationIndicatorCircleStrokeSpin.h"
#import "WBIndicatorViewProtocol.h"
#import "WBLoadingIndicatorView.h"

FOUNDATION_EXPORT double WBLoadingIndicatorViewVersionNumber;
FOUNDATION_EXPORT const unsigned char WBLoadingIndicatorViewVersionString[];

