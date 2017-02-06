//
//  SanKit.h
//  SanKit
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* 自定义Log  ------------------------------------------------------------- */

#ifdef DEBUG
  #define Log(f,args...)   NSLog(@"行%u %s\n %@",__LINE__,__PRETTY_FUNCTION__,[NSString stringWithFormat:f, args]);
  #define SLog(str)        NSLog(@"行%u %s\n %@",__LINE__,__PRETTY_FUNCTION__,str);
#else
  #define Log(f,args...)
  #define SLog(str)
#endif

/* 自定义Log 结束  -------------------------------------------------------------  */



#import "NSArray+Sankit.h"
#import "NSDate+Sankit.h"
#import "NSDictionary+Sankit.h"
#import "NSMutableArray+Sankit.h"
#import "NSMutableDictionary+Sankit.h"
#import "NSNumber+Sankit.h"
#import "NSObject+Sankit.h"
#import "NSString+Sankit.h"
#import "NSTimer+Sankit.h"
#import "NSUserDefaults+Sankit.h"
#import "UIAlertController+Sankit.h"
#import "UIApplication+Sankit.h"
#import "UIButton+Sankit.h"
#import "UIColor+Sankit.h"
#import "UIImage+Sankit.h"
#import "UINavigationController+Sankit.h"
#import "UIScrollView+Sankit.h"
#import "UIViewController+Sankit.h"
#import "UIView+Sankit.h"

#import "SanIcon.h"

#import "SFCache.h"
#import "SFMacro.h"
#import "SFKeyChainStore.h"
#import "SFLabel.h"
#import "SFTextField.h"
#import "SFTriangleView.h"
#import "SFUIViewController.h"
#import "SFUITableViewController.h"
#import "SFUtility.h"
#import "SFButton.h"

//#import "Reachability.h"
#import "UIImage+ImageEffects.h"
