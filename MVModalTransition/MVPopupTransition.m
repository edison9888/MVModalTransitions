/*
 MVPopupTransition.m
 Copyright (c) 2014 Andrea Bizzotto bizz84@gmail.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "MVPopupTransition.h"

@implementation MVPopupTransition

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = transitionContext.containerView;

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    BOOL isBeingPresented = toVC.isBeingPresented;

    // Start from center
    // Valid for present, not dismiss
    UIView *presentingView = toVC.isBeingPresented ? fromView : toView;
    CGRect beginFrame = [[self class] centeredRectWithView:presentingView size:CGSizeZero];
    CGSize modalSize = self.presentedViewSize;
    if (isBeingPresented) {
        // For some reason we need to swap width and height (but not center coordinates) on the presented view in landscape
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            modalSize = CGSizeMake(modalSize.height, modalSize.width);
        }
    }
    CGRect endFrame = [[self class] centeredRectWithView:presentingView size:modalSize];


    // Code for popup
    UIView *move = nil;
    if (isBeingPresented) {
        // Used later for dismissal
        self.presentedViewController = toVC;

        // Snapshot
        toView.frame = endFrame;
        move = [toView snapshotViewAfterScreenUpdates:YES];
        move.frame = beginFrame;
        move.alpha = 0.0f;

        [self prepareDimmedBackground:container];

    } else {
        // Snapshot
        move = [fromView snapshotViewAfterScreenUpdates:YES];
        move.frame = endFrame;
        move.alpha = 1.0f;
        [fromView removeFromSuperview];
    }
    move.transform = CGAffineTransformMakeRotation((float)[self rotationAngleForOrientation]);

    [container addSubview:move];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:500 initialSpringVelocity:15 options:0 animations:^{

        move.frame = isBeingPresented ? endFrame : beginFrame;
        move.alpha = isBeingPresented ? 1.0f : 0.0f;

        // Animate dimmed background view
        [self presentDimmedBackgroundAnimation:isBeingPresented];
    }
                     completion:^(BOOL finished) {
                         if (isBeingPresented) {
                             [move removeFromSuperview];
                             //toView.frame = endFrame;
                             [container addSubview:toView];
                             toView.frame = endFrame;
                             if ([self.delegate respondsToSelector:@selector(rootViewControllerDidPresent)]) {
                                [self.delegate rootViewControllerDidPresent];
                             }
                         } else {
                             // Remove at end of animation
                             [self removeDimmedBackgroundCompletion];

                             // Anything needed for dealloc to be called!
                             self.presentedViewController = nil;
                             if ([self.delegate respondsToSelector:@selector(rootViewControllerDidDismiss)]) {
                                 [self.delegate rootViewControllerDidDismiss];
                             }
                         }
                         [transitionContext completeTransition: YES];
                     }];
}

- (double)rotationAngleForOrientation {

    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        default:
        case UIInterfaceOrientationPortrait:
            return 0.0;
        case UIInterfaceOrientationPortraitUpsideDown:
            return M_PI;
        case UIInterfaceOrientationLandscapeLeft:
            return -M_PI_2;
        case UIInterfaceOrientationLandscapeRight:
            return M_PI_2;
    }
}

@end