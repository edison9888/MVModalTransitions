/*
 MVModalTransition.h
 Copyright (c) 2014 Andrea Bizzotto bizz84@gmail.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import <Foundation/Foundation.h>

@protocol MVModalTransitionDelegate <NSObject>
@optional
- (void)rootViewControllerDidPresent;
- (void)rootViewControllerDidDismiss;
@end

@interface MVModalTransition : NSObject <UIViewControllerAnimatedTransitioning>

/*
 @param size size of view to be presented
 @param dimBackground whether background should be dimmed
 @param shouldDismissOnBackgroundViewTap dismisses view controller when user taps on background view
 @param delegate delegate to be notified when presented/dismissed
*/
+ (instancetype)createWithSize:(CGSize)size dimBackground:(BOOL)dimBackground shouldDismissOnBackgroundViewTap:(BOOL)shouldDismissOnBackgroundViewTap delegate:(id<MVModalTransitionDelegate>)delegate;

+ (CGRect)centeredRectWithView:(UIView *)fromView size:(CGSize)size;

// Methods to be called by subclasses as part of [animateTransition:]
- (void)prepareDimmedBackground:(UIView *)container;
- (void)presentDimmedBackgroundAnimation:(BOOL)isBeingPresented;
- (void)removeDimmedBackgroundCompletion;

@property (nonatomic) CGSize presentedViewSize;
@property (nonatomic) UIViewController *presentedViewController;

@property (nonatomic, readonly) BOOL shouldDismissOnBackgroundViewTap;
@property (nonatomic, readonly) UIView *dimmedBackgroundView;
@property (weak, readonly) id<MVModalTransitionDelegate> delegate;

@end