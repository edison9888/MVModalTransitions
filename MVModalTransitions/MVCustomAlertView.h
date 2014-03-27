//
// Created by Andrea Bizzotto on 17/10/2013.
// Copyright (c) 2013 Snupps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVCustomAlertView;

@protocol MVCustomAlertViewClientDelegate<NSObject>
- (void)customAlertViewDidCancel:(MVCustomAlertView *)alertView;
@optional
- (void)customAlertViewDidConfirm:(MVCustomAlertView *)alertView;
// Subclasses can extend protocol for positive flows
@end

@protocol MVCustomAlertViewDelegate
- (UIView *)contentView;
- (BOOL)onConfirm;
@end

/*
 Reusable custom alert view class.
 Subclass to add contentView(s) (see MVPickerAlertView).
 */
@interface MVCustomAlertView : UIViewController<MVCustomAlertViewDelegate>

- (id)initWithPresentingViewController:(UIViewController *)presentingViewController delegate:(id<MVCustomAlertViewClientDelegate>)delegate;

- (void)show;

- (void) cancelButtonTitle:(NSString *)cancelTitle confirmButtonTitle:(NSString *)confirmButtonTitle;

@property (weak, readonly) id<MVCustomAlertViewClientDelegate> delegate;

@property(weak, nonatomic, readonly) UIViewController *presentingTopViewController;
@end