//
//  SLibUIViewController.m
//  SanFramework
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

#import "SFUIViewController.h"
#import "SFMacro.h"
#import "UIView+Sankit.h"
#import "UIColor+Sankit.h"

@interface SFUIViewController ()

@end

@implementation SFUIViewController

@synthesize activityIndicator = _activityIndicator;
@synthesize viewNeedLogin = _viewNeedLogin;

#pragma mark 缺省继承
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _viewNeedLogin = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self setNeedsStatusBarAppearanceUpdate];

    self.view.backgroundColor = [UIColor clearColor];
    
    if (DEBUG_ON) NSLog(@"%@ ViewDidLoad", [[self class] description]);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (DEBUG_ON) NSLog(@"%@ ViewWillAppear", [[self class] description]);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (DEBUG_ON) NSLog(@"%@ ViewDidAppear", [[self class] description]);
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (DEBUG_ON) NSLog(@"%@ ViewWillDisappear", [[self class] description]);
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (DEBUG_ON) NSLog(@"%@ ViewDidDisappear", [[self class] description]);
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (DEBUG_ON) NSLog(@"%@ ViewWillLayoutSubviews", [[self class] description]);
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (DEBUG_ON) NSLog(@"%@ ViewDidLayoutSubviews", [[self class] description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (DEBUG_ON) NSLog(@"%@ DidReceiveMemoryWarning", [[self class] description]);
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	if (DEBUG_ON) NSLog(@"%@ willMoveToParentViewController %@", [[self class] description], parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
	if (DEBUG_ON) NSLog(@"%@ didMoveToParentViewController %@", [[self class] description], parent);
}

- (void) dealloc
{
    if (DEBUG_ON) NSLog(@"%@ dealloc", [[self class] description]);
}



- (void) popTo: (UIViewController *)vc
{
    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[vc class]]){
            //[[self navigationController] setViewControllers:[NSArray arrayWithObject:vc] animated:NO];
            [[self navigationController] popToViewController:obj animated:NO];
            self.view = nil;
            return;
        }
    }
    [self.navigationController pushViewController:vc animated:NO];
}



#pragma mark - 指示器
- (void) startIndicator
{
    // 加个指示器 并启动
    if (self.activityIndicator) [self.activityIndicator removeFromSuperview];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.center = self.view.center;
    [self.view addSubview: self.activityIndicator];
    [self.activityIndicator startAnimating];
}

- (void) stopIndicator
{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}



#pragma mark - 状态条设置
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}





#pragma mark 横竖屏控制
- (BOOL) shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
