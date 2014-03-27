
MVModalTransitions - Andrea Bizzotto <bizz84@gmail.com>

-------------------------------------------------------

This project shows how to present custom view controllers modally on iPad and iPhone without recurring to the UIModalPresentationFormSheet and UIModalPresentationPageSheet presentation styles which are available on iPad only.

This is done by using the View Controller Transitioning APIs introduced in iOS7. Specifically, some custom classes implementing the UIViewControllerAnimatedTransitioning protocol. Please refer to the MVModalTransition and MVPopupTransition for how this is implemented.

Example:

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

License information can be found in the LICENSE.md file.

