//
// Created by Andrea Bizzotto on 03/01/2014.
// Copyright (c) 2014 Snupps. All rights reserved.
//

#import "MVModalTransition.h"
#import "MASConstraintMaker.h"
#import "View+MASShorthandAdditions.h"

static float kTransitionDuration = 0.5f;
static float kDimmedBackgroundTargetAlpha = 0.8f;

@interface MVModalTransition ()
@property (nonatomic) BOOL shouldDismissOnBackgroundViewTap;
@property (nonatomic) BOOL dimBackground;
@property (nonatomic) UIView *dimmedBackgroundView;
@property (weak) id<MVModalTransitionDelegate> delegate;

@end

@implementation MVModalTransition


+ (instancetype)createWithSize:(CGSize)size dimBackground:(BOOL)dimBackground shouldDismissOnBackgroundViewTap:(BOOL)shouldDismissOnBackgroundViewTap delegate:(id<MVModalTransitionDelegate>)delegate {

    return [[self alloc] initWithSize:size dimBackground:dimBackground shouldDismissOnBackgroundViewTap:shouldDismissOnBackgroundViewTap delegate:delegate];
}

- (id)initWithSize:(CGSize)size dimBackground:(BOOL)dimBackground shouldDismissOnBackgroundViewTap:(BOOL)shouldDismissOnBackgroundViewTap delegate:(id<MVModalTransitionDelegate>)delegate {

    if (self = [super init]) {
        self.dimBackground = dimBackground;
        self.presentedViewSize = size;
        self.shouldDismissOnBackgroundViewTap = shouldDismissOnBackgroundViewTap;
        self.delegate = delegate;
    }
    return self;
}

- (UIView *)dimmedBackgroundView
{
    if (_dimmedBackgroundView == nil) {
        _dimmedBackgroundView = [UIView new];
        [_dimmedBackgroundView setBackgroundColor:[UIColor colorWithWhite:0 alpha:kDimmedBackgroundTargetAlpha]];
        if (self.shouldDismissOnBackgroundViewTap) {
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)];
            [_dimmedBackgroundView addGestureRecognizer:gestureRecognizer];
        }
    }
    return _dimmedBackgroundView;
}

- (void)backgroundViewTapped {

    __block MVModalTransition *bSelf = self;
    [bSelf.presentedViewController dismissViewControllerAnimated:YES completion:^{
        bSelf.presentedViewController = nil;
    }];
}

- (void)prepareDimmedBackground:(UIView *)container
{
    if (self.dimBackground) {
        if (self.dimmedBackgroundView.superview != nil) {
            [self.dimmedBackgroundView removeFromSuperview];
        }
        self.dimmedBackgroundView.alpha = 0.0f;
        [container addSubview:self.dimmedBackgroundView];
        [self.dimmedBackgroundView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(container);
        }];
    }
}

- (void)presentDimmedBackgroundAnimation:(BOOL)isBeingPresented {
    if (self.dimBackground) {
        self.dimmedBackgroundView.alpha = isBeingPresented ? [self dimmedBackgroundTargetAlpha] : 0.0f;
    }
}

- (void)removeDimmedBackgroundCompletion {

    if (self.dimBackground) {
        [self.dimmedBackgroundView removeFromSuperview];
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(NO, @"This must be implemented by subclasses");
}

+ (CGRect)centeredRectWithView:(UIView *)fromView size:(CGSize)size {

    CGSize fromViewSize = fromView.frame.size;
    CGRect rect = CGRectMake(fromViewSize.width / 2 - size.width / 2, fromViewSize.height / 2 - size.height / 2, size.width, size.height);
    return rect;
}

- (float)dimmedBackgroundTargetAlpha {
    return kDimmedBackgroundTargetAlpha;
}


@end
