/*
 MVModalTransition.m
 Copyright (c) 2014 Andrea Bizzotto bizz84@gmail.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


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
