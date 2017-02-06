//
//  UIViewController+Sankit.m
//  cyh
//
//  Created by Shelley Shyan on 16/3/29.
//  Copyright © 2016年 WisdomSource. All rights reserved.
//

#import "UIViewController+Sankit.h"
#import "UIView+Sankit.h"

@implementation UIViewController (Sankit)

+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {// Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {// Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {// Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {// Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {// Unknown vc type, return last child vc
        return vc;
    }

}

+ (UIViewController*)currentViewController {
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

- (void)removePreviusViewController {
    //
}




#pragma mark - 键盘事件
- (void)registerKeyboardNotification
{
    // 键盘Frame将要改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregisterKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;

    CGRect newFrame = self.view.frame;

    if (yOffset > 100) { // keyboard hide
        newFrame.origin.y = 0;
    } else {
        newFrame.origin.y += yOffset;
    }

    [UIView animateWithDuration:duration animations:^{self.view.frame = newFrame;}];
}


- (void) addHideKeyboardGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findAndHideKeyboard)];

    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;

    [self.view addGestureRecognizer:tapGesture];
}

- (void) findAndHideKeyboard
{
    [[self.view findFirstResponder] resignFirstResponder];
}

@end
