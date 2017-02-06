//
//  UIButton+Sankit.h
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

#import <UIKit/UIKit.h>

@interface UIButton (Sankit)

/**
 * 设置背景颜色
 */
- (void)setBackgroundColorNormalState:(UIColor *)color;

/**
 * 设置标题
 */
- (void)setTitle:(NSString *)title;

/**
 * 设置标题的颜色
 */
- (void)setTitleColor:(UIColor *)color;

/**
 * 设置标题高亮时的颜色
 */
- (void)setTitleColorHighlighted:(UIColor *)color;

/**
 * 设置标题的字号大小
 */
- (void)setTitleSize:(CGFloat)size;

/**
 * 设置标题文字左对齐
 */
- (void) setTitleTextAlignmentLeft;

/**
 * 设置标题文字居中
 */
- (void) setTitleTextAlignmentCenter;

/**
 * 设置标题文字右对齐
 */
- (void) setTitleTextAlignmentRight;

@end
