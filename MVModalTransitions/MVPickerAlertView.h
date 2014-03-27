//
// Created by Andrea Bizzotto on 27/03/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVCustomAlertView.h"


@interface MVPickerAlertView : MVCustomAlertView

- (id)initWithTitle:(NSString *)title values:(NSArray *)values presentingViewController:(UIViewController *)presentingViewController delegate:(id)delegate;

@end