MVModalTransitions
=======================================================

This is a light-weight library to present custom view controllers on iPad and iPhone without recurring to the UIModalPresentationFormSheet and UIModalPresentationPageSheet presentation styles (which are only available on iPad).

With iOS 7, Apple introduced the new View Controller Transitioning APIs. These are used by the MVModalTransition and MVPopupTransition classes to present non-fullscreen interface-rotation friendly modal view controllers.
The MVModalTransition class can be used as a base class to implement custom transitions and provides support for adding a semi-transparent full-screen background view.

This sample project comes with a custom modal picker view that illustrates how to use this.

Usage
-------------------------------------------------------

<pre>
/* -- Presented view controller code -- */
@interface MVCustomAlertView ()<UIViewControllerTransitioningDelegate>
@property(strong, nonatomic) MVPopupTransition *animator;
@end

@implementation MVCustomAlertView

- (id)init {

    if ((self = [super init])) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        self.animator = [MVPopupTransition createWithSize:CGSizeMake(300, 300) dimBackground:YES shouldDismissOnBackgroundViewTap:NO delegate:nil];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animator;
}
@end


/* -- Presenting view controller code -- */
@implementation PresentingViewController

// Handler
- (void)buttonPressed {

  MVCustomAlertView *vc = [MyViewController new];
  [self presentViewController:vc animated:YES completion:nil];  
}
</pre>

Installation
-------------------------------------------------------

This example uses Masonry on top of Auto-Layout. The corresponding pod needs to be installed before the project can be built.

<pre>
pod install
</pre>

Scope
-------------------------------------------------------
The custom popup transition can be used to present modal view controllers as long as:
- their size doesn't change with interface rotation
- their width and height do not exceed the smallest of the screen dimensions

License
-------------------------------------------------------
License information can be found in the LICENSE.md file.

Preview
-------------------------------------------------------

![Modal View Controllers Preview](https://github.com/bizz84/MVModalTransitions/raw/master/Screenshots/ModalPortrait.png "Modal View Controllers Preview")

Contact
-------------------------------------------------------
Andrea Bizzotto - <bizz84@gmail.com>
