//
// Created by Andrea Bizzotto on 03/01/2014.
// Copyright (c) 2014 Snupps. All rights reserved.
//

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