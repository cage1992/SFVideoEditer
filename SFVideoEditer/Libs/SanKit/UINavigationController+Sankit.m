//
//  UINavigationController+Sankit.m
//  Sankit
//
//  Created by shelley on 14-1-12.
//  Copyright (c) 2014 Sanfriend Co, Ltd. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UINavigationController+Sankit.h"

@implementation UINavigationController (Sankit)

/*
- (void)pushViewController:(UIViewController *)vc withTransition:(UIViewAnimationTransition)transition animatimationDuration:(NSTimeInterval)ti animated:(BOOL)animated
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:ti];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:transition
                           forView:self.view cache:NO];
    
    
    [self pushViewController:vc animated:animated];
    [UIView commitAnimations];
}

- (void)popWithTransition:(UIViewAnimationTransition)aTransition animationDuration:(NSTimeInterval)ti animated:(BOOL)animated
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:ti];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:aTransition forView:self.view cache:YES];
    [UIView commitAnimations];
    [self popViewControllerAnimated:animated];
}
*/

@end
