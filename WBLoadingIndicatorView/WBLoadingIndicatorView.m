//
//  WBLoadingIndicatorView.m
//  WBLoadingIndicatorView_Example
//
//  Created by Mr_Lucky on 2018/9/7.
//  Copyright © 2018年 wenmobo. All rights reserved.
//

#import "WBLoadingIndicatorView.h"
#import "WBIndicatorContainerView.h"

#import "WBAnimationIndicatorCircleStrokeSpin.h"
#import "WBAnimationIndicatorBallPulse.h"
#import "WBAnimationIndicatorBallClipRotate.h"
#import "WBAnimationIndicatorBallClipRotatePulse.h"
#import "WBAnimationIndicatorBallClipRotateMultiple.h"
#import "WBAnimationIndicatorBallTrianglePath.h"
#import "WBAnimationIndicatorBallSurround.h"

static const CGFloat WBDefaultPadding = 5.f;

@interface WBLoadingIndicatorView ()

@property (nonatomic, strong) WBIndicatorContainerView *animationView;
@property (nonatomic, strong) NSArray *bezelConstraints;
@property (nonatomic, strong) UIView *topSpacer;
@property (nonatomic, strong) UIView *bottomSpacer;

@end

@implementation WBLoadingIndicatorView

- (instancetype)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

+ (instancetype)wb_showIndicatorAddTo:(UIView *)view {
    WBLoadingIndicatorView *indicator = [[self alloc]initWithView:view];
    [view addSubview:indicator];
    [indicator wb_showLoadingView:YES];
    return indicator;
}

+ (nullable WBLoadingIndicatorView *)wb_indicatorForView:(UIView *)view {
    NSEnumerator *enuerator = [view.subviews reverseObjectEnumerator];
    for (UIView *subView in enuerator) {
        if ([subView isKindOfClass:[WBLoadingIndicatorView class]]) {
            WBLoadingIndicatorView *indicatorView = (WBLoadingIndicatorView *)subView;
            return indicatorView;
        }
    }
    return nil;
}

// MARK:Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _margin = 20.f;
    _indicatorSize = CGSizeMake(35, 35);
    _type = WBLoadingAnimationcircleStrokeSpin;
    _removeFromSuperViewOnHide = YES;
    BOOL isLegacy = kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0;
    _contentColor = isLegacy ? [UIColor whiteColor] : [UIColor colorWithWhite:0.f alpha:0.7f];
    // Transparent background
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    // Make it invisible for now
    self.alpha = 0.0f;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.layer.allowsGroupOpacity = NO;
    
    [self setupViews];
    [self updateIndicators];
}

- (void)setupViews {
    UIColor *defaultColor = self.contentColor;
    
    self.backgroundView = ({
        WBLoadingBackgroundView *backgroundView = [[WBLoadingBackgroundView alloc]initWithFrame:self.bounds];
        backgroundView.style = WBLoadingIndicatorBackgroundSolidStyle;
        backgroundView.backgroundColor = [UIColor clearColor];
        backgroundView.alpha = 0.f;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:backgroundView];
        backgroundView;
    });
    
    self.bezelView = ({
        WBLoadingBackgroundView *bezelView = [WBLoadingBackgroundView new];
        bezelView.translatesAutoresizingMaskIntoConstraints = NO;
        bezelView.layer.cornerRadius = 5.f;
        bezelView.alpha = 0.f;
        [self addSubview:bezelView];
        bezelView;
    });
    
    self.label = ({
        UILabel *label = [UILabel new];
        label.adjustsFontSizeToFitWidth = NO;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = defaultColor;
        label.font = [UIFont boldSystemFontOfSize:15.f];
        label.opaque = NO;
        label.backgroundColor = [UIColor clearColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisVertical];
        [self.bezelView addSubview:label];
        label;
    });
    
    self.topSpacer = ({
        UIView *topSpacer = [UIView new];
        topSpacer.translatesAutoresizingMaskIntoConstraints = NO;
        topSpacer.hidden = YES;
        [self.bezelView addSubview:topSpacer];
        topSpacer;
    });
    
    self.bottomSpacer = ({
        UIView *bottomSpacer = [UIView new];
        bottomSpacer.translatesAutoresizingMaskIntoConstraints = NO;
        bottomSpacer.hidden = YES;
        [self.bezelView addSubview:bottomSpacer];
        bottomSpacer;
    });
    
    self.animationView = ({
        WBIndicatorContainerView *animationView = [WBIndicatorContainerView new];
        animationView.translatesAutoresizingMaskIntoConstraints = NO;
        animationView.alpha = 0.f;
        [self.bezelView addSubview:animationView];
        animationView;
    });
}

// MARK:Layout
- (void)updateConstraints {
    UIView *bezel = self.bezelView;
    UIView *topSpacer = self.topSpacer;
    UIView *bottomSpacer = self.bottomSpacer;
    UIView *indicator = self.animationView;
    UILabel *label = self.label;
    
    CGFloat margin = self.margin;
    
    NSMutableArray *bezelConstraints = [NSMutableArray array];
    
    NSDictionary *metrics = @{@"margin": @(margin)};
    
    // Remove existing constraints
    [self removeConstraints:self.constraints];
    [topSpacer removeConstraints:topSpacer.constraints];
    [bottomSpacer removeConstraints:bottomSpacer.constraints];
    if (self.bezelConstraints) {
        [bezel removeConstraints:self.bezelConstraints];
        self.bezelConstraints = nil;
    }
    
    // Center bezel in container (self), applying the offset if set
    CGPoint offset = self.offset;
    NSMutableArray *centeringConstraints = [NSMutableArray array];
    [centeringConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.f
                                                                  constant:offset.x]];
    [centeringConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.f
                                                                  constant:offset.y]];
    [self applyPriority:998.f toConstraints:centeringConstraints];
    [self addConstraints:centeringConstraints];
    
    // Ensure minimum side margin is kept
    NSMutableArray *sideConstraints = [NSMutableArray array];
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[bezel]-(>=margin)-|"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:NSDictionaryOfVariableBindings(bezel)]];
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[bezel]-(>=margin)-|"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:NSDictionaryOfVariableBindings(bezel)]];
    [self applyPriority:999.f toConstraints:sideConstraints];
    [self addConstraints:sideConstraints];
    
    // Minimum bezel size, if set
    CGSize minimumSize = self.minSize;
    if (!CGSizeEqualToSize(minimumSize, CGSizeZero)) {
        NSMutableArray *minSizeConstraints = [NSMutableArray array];
        [minSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.f
                                                                    constant:minimumSize.width]];
        [minSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.f
                                                                    constant:minimumSize.height]];
        [self applyPriority:997.f toConstraints:minSizeConstraints];
        [bezelConstraints addObjectsFromArray:minSizeConstraints];
    }
    
    if (self.square) {
        NSLayoutConstraint *square = [NSLayoutConstraint constraintWithItem:bezel
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:bezel
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.f
                                                                   constant:0.f];
        square.priority = 997.f;
        [bezelConstraints addObject:square];
    }
    
    // topSpacer
    [topSpacer addConstraint:[NSLayoutConstraint constraintWithItem:topSpacer
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.f
                                                           constant:margin]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:topSpacer
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.f
                                                              constant:0.f]];
    [bezelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[topSpacer]-(>=margin)-|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:NSDictionaryOfVariableBindings(topSpacer)]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:topSpacer
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.f
                                                              constant:0.f]];
    
    //indicator
    NSMutableArray *indicatorSizeConstraints = @[].mutableCopy;
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:indicator
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.f
                                                              constant:0.f]];
    [indicatorSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:indicator
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.f
                                                                      constant:_indicatorSize.width]];
    [indicatorSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:indicator
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.f
                                                                      constant:_indicatorSize.height]];
    [self applyPriority:996.f toConstraints:indicatorSizeConstraints];
    [bezelConstraints addObjectsFromArray:indicatorSizeConstraints];
    [bezelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[indicator]-(>=margin)-|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:NSDictionaryOfVariableBindings(indicator)]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:indicator
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:topSpacer
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:WBDefaultPadding]];
    
    //label
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:label
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.f
                                                              constant:0.f]];
    [bezelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[label]-(>=margin)-|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:NSDictionaryOfVariableBindings(label)]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:label
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:indicator
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:WBDefaultPadding]];
    
    
    //bottomSpacer
    [bottomSpacer addConstraint:[NSLayoutConstraint constraintWithItem:bottomSpacer
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.f
                                                              constant:margin]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:bottomSpacer
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.f
                                                              constant:0.f]];
    [bezelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[bottomSpacer]-(>=margin)-|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:NSDictionaryOfVariableBindings(bottomSpacer)]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:bottomSpacer
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:label
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:0.f]];
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:bottomSpacer
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bezel
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:0.f]];
    
    
    // Top and bottom spaces should be equal
    [bezelConstraints addObject:[NSLayoutConstraint constraintWithItem:topSpacer
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bottomSpacer
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.f
                                                              constant:0.f]];
    
    [bezel addConstraints:bezelConstraints];
    self.bezelConstraints = bezelConstraints;
    
    [super updateConstraints];
}

- (void)applyPriority:(UILayoutPriority)priority
        toConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}

// MARK:View Hierarchy
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        self.frame = newSuperview.bounds;
    }
}

// MARK:Show
- (void)wb_showLoadingView:(BOOL)animated {
    /** < Remove layer animations. > */
    [self.bezelView.layer removeAllAnimations];
    [self.backgroundView.layer removeAllAnimations];
    
    if (animated) {
        [UIView animateWithDuration:0.3f
                              delay:0.f
             usingSpringWithDamping:1.f
              initialSpringVelocity:0.f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = 1.f;
                             self.bezelView.alpha = 1.f;
                             self.backgroundView.alpha = 1.f;
                             self.animationView.alpha = 1.f;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }else {
        self.alpha = 1.f;
        self.bezelView.alpha = 1.f;
        self.backgroundView.alpha = 1.f;
        self.animationView.alpha = 1.f;
    }
    
}

// MARK:Hide
- (void)wb_hideLoadingView:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3f
                              delay:0.f
             usingSpringWithDamping:1.f
              initialSpringVelocity:0.f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.backgroundView.alpha = 0.f;
                             self.bezelView.alpha = 0.f;
                             self.alpha = 0.f;
                             self.animationView.alpha = 0.f;
                         }
                         completion:^(BOOL finished) {
                             if (self.removeFromSuperViewOnHide) {
                                 [self removeFromSuperview];
                             }
                         }];
    }else {
        self.backgroundView.alpha = 0.f;
        self.bezelView.alpha = 0.f;
        self.alpha = 0.f;
        self.animationView.alpha = 0.f;
        if (self.removeFromSuperViewOnHide) {
            [self removeFromSuperview];
        }
    }
}

// MARK:Private Method
- (void)updateIndicators {
    
    __weak typeof(self) weakSelf = self;
    self.animationView.layoutEnd = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        /** < Remove layer animations. > */
        [strongSelf.animationView.layer removeAllAnimations];
        [strongSelf.animationView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        strongSelf.animationView.layer.sublayers = nil;
        strongSelf.animationView.layer.speed = 1.f;
        
        /*  < 添加动画 > */
        switch (strongSelf.type) {
            case WBLoadingAnimationcircleStrokeSpin:
            {
                WBAnimationIndicatorCircleStrokeSpin *circleStrokeSpin = [WBAnimationIndicatorCircleStrokeSpin new];
                [circleStrokeSpin wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                      size:strongSelf.indicatorSize
                                                     color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallPulse:
            {
                WBAnimationIndicatorBallPulse *ballPulse = [WBAnimationIndicatorBallPulse new];
                [ballPulse wb_addAnimationWithLayer:strongSelf.animationView.layer
                                               size:strongSelf.indicatorSize
                                              color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallClipRotate:
            {
                WBAnimationIndicatorBallClipRotate *ballClipRotate = [WBAnimationIndicatorBallClipRotate new];
                [ballClipRotate wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                    size:strongSelf.indicatorSize
                                                   color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallClipRotatePulse:
            {
                WBAnimationIndicatorBallClipRotatePulse *ballClipRotatePulse = [WBAnimationIndicatorBallClipRotatePulse new];
                [ballClipRotatePulse wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                         size:strongSelf.indicatorSize
                                                        color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallClipRotateMultiple:
            {
                WBAnimationIndicatorBallClipRotateMultiple *ballClipRotateMultiple = [WBAnimationIndicatorBallClipRotateMultiple new];
                [ballClipRotateMultiple wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                            size:strongSelf.indicatorSize
                                                           color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallTrianglePath:
            {
                WBAnimationIndicatorBallTrianglePath *ballTrianglePath = [WBAnimationIndicatorBallTrianglePath new];
                [ballTrianglePath wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                      size:strongSelf.indicatorSize
                                                     color:strongSelf.indicatorColor ? :strongSelf.contentColor];
            }
                break;
            case WBLoadingAnimationBallSurround:
            {
                WBAnimationIndicatorBallSurround *ballSurround = [WBAnimationIndicatorBallSurround new];
                [ballSurround wb_addAnimationWithLayer:strongSelf.animationView.layer
                                                  size:strongSelf.indicatorSize
                                                 color:strongSelf.indicatorColor ? :strongSelf.contentColor];

            }
                break;
            default:
                break;
        }
    };
    
    [self setNeedsUpdateConstraints];
    [self.animationView setNeedsLayout];
}

- (void)updateViewForColor:(UIColor *)color {
    self.label.textColor = color;
    [self updateIndicators];
}

// MARK:Setter
- (void)setType:(WBLoadingAnimationType)type {
    if (type != _type) {
        _type = type;
        [self updateIndicators];
    }
}

- (void)setOffset:(CGPoint)offset {
    if (!CGPointEqualToPoint(_offset, offset)) {
        _offset = offset;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMargin:(CGFloat)margin {
    if (margin != _margin) {
        _margin = margin;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMinSize:(CGSize)minSize {
    if (!CGSizeEqualToSize(minSize, _minSize)) {
        _minSize = minSize;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setIndicatorSize:(CGSize)indicatorSize {
    if (!CGSizeEqualToSize(indicatorSize, _indicatorSize)) {
        _indicatorSize = indicatorSize;
        [self updateIndicators];
    }
}

- (void)setContentColor:(UIColor *)contentColor {
    if (contentColor != _contentColor && ![contentColor isEqual:_contentColor]) {
        _contentColor = contentColor;
        [self updateViewForColor:contentColor];
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if (indicatorColor != _indicatorColor && ![indicatorColor isEqual:_indicatorColor]) {
        _indicatorColor = indicatorColor;
        [self updateIndicators];
    }
}

- (void)setSquare:(BOOL)square {
    if (square != _square) {
        _square = square;
        [self setNeedsUpdateConstraints];
    }
}

@end

@interface WBLoadingBackgroundView ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation WBLoadingBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
            _style = WBLoadingIndicatorBackgroundBlurStyle;
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
            _blurEffectStyle = UIBlurEffectStyleLight;
#endif
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
                _color = [UIColor colorWithWhite:0.8f alpha:0.6f];
            }else {
                _color = [UIColor colorWithWhite:0.95f alpha:0.6f];
            }
        }else {
            _style = WBLoadingIndicatorBackgroundSolidStyle;
            _color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        }
        
        self.clipsToBounds = YES;
        [self updateForBackgroundStyle];
    }
    return self;
}

- (void)updateForBackgroundStyle {
    WBLoadingIndicatorBackgroundStyle style = self.style;
    if (style == WBLoadingIndicatorBackgroundBlurStyle) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            effectView.frame = self.bounds;
            effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            self.backgroundColor = self.color;
            self.layer.allowsGroupOpacity = NO;
            self.effectView = effectView;
        } else {
#endif
#if !TARGET_OS_TV
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectInset(self.bounds, -100.f, -100.f)];
            toolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            toolbar.barTintColor = self.color;
            toolbar.translucent = YES;
            [self addSubview:toolbar];
            self.toolbar = toolbar;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
    }else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            [self.effectView removeFromSuperview];
            self.effectView = nil;
        } else {
#endif
#if !TARGET_OS_TV
            [self.toolbar removeFromSuperview];
            self.toolbar = nil;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
        self.backgroundColor = self.color;
    }
}

- (void)updateViewsForColor:(UIColor *)color {
    if (self.style == WBLoadingIndicatorBackgroundBlurStyle) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            self.backgroundColor = self.color;
        } else {
#if !TARGET_OS_TV
            self.toolbar.barTintColor = color;
#endif
        }
    } else {
        self.backgroundColor = self.color;
    }
}

// MARK:Setter
- (void)setStyle:(WBLoadingIndicatorBackgroundStyle)style {
    if (style == WBLoadingIndicatorBackgroundBlurStyle && kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0) {
        style = WBLoadingIndicatorBackgroundSolidStyle;
    }
    if (_style != style) {
        _style = style;
        [self updateForBackgroundStyle];
    }
}

- (void)setColor:(UIColor *)color {
    NSAssert(color, @"The color should not be nil.");
    if (color != _color && ![color isEqual:_color]) {
        _color = color;
        [self updateViewsForColor:color];
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV

- (void)setBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle {
    if (_blurEffectStyle == blurEffectStyle) {
        return;
    }
    _blurEffectStyle = blurEffectStyle;
    [self updateForBackgroundStyle];
}

#endif

#pragma mark - Layout
- (CGSize)intrinsicContentSize {
    // Smallest size possible. Content pushes against this.
    return CGSizeZero;
}

@end
