//
//  UIViewController+Sankit.h
//  cyh
//
//  Created by Shelley Shyan on 16/3/29.
//  Copyright © 2016年 WisdomSource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Sankit)

+ (UIViewController*)currentViewController;

- (void)removePreviusViewController;

- (void)registerKeyboardNotification;
- (void)unregisterKeyboardNotification;
- (void)keyboardWillChangeFrame:(NSNotification *)notification;

- (void) addHideKeyboardGesture;
- (void) findAndHideKeyboard;

@end
