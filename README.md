
MVModalTransitions - Andrea Bizzotto <bizz84@gmail.com>

=======================================================


This is a light-weight library that shows how to present custom view controllers modally on iPad and iPhone without recurring to the UIModalPresentationFormSheet and UIModalPresentationPageSheet presentation styles which are only available on iPad.

On iOS 7, Apple introduced the new View Controller Transitioning APIs, which are used by the MVModalTransition and MVPopupTransition classes to present non-fullscreen interface-rotation friendly modal view controllers.
The MVModalTransition class can be used as a base class to implement custom transition and provides support for adding a semi-transparent full-screen background view.

This sample project comes with a custom modal picker view that illustrates how to use this.

USAGE
-------------------------------------------------------

<pre>
@implementation PresentingViewController

// Call this on viewDidLoad
- (void)setupAnimator {
  self.animator = [MVPopupTransition createWithSize:CGSizeMake(300, 300) dimBackground:YES shouldDismissOnBackgroundViewTap:NO delegate:nil];
}

// Handler
- (void)presentModalViewController {

  MyViewController *vc = [MyViewController new];
  vc.transitioningDelegate = self;
  vc.modalPresentationStyle = UIModalPresentationCustom;
  [self presentViewController:vc animated:YES completion:nil];  
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
</pre>

INSTALLATION
-------------------------------------------------------

This example uses Masonry on top of Auto-Layout. The corresponding pod needs to be installed before the project can be built.

<pre>
pod install
</pre>

License information can be found in the LICENSE.md file.

![Modal View Controllers Preview](https://github.com/bizz84/MVModalTransitions/raw/master/Screenshots/ModalPortrait.png "Modal View Controllers Preview")