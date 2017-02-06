//
//  UIButton+Sankit.m
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

#import "UIButton+Sankit.h"
#import "UIImage+Sankit.h"

@implementation UIButton (Sankit)

- (void)setBackgroundColorNormalState:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
}



- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setTitleColorHighlighted:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (void)setTitleSize:(CGFloat)size {
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}



- (void) setTitleTextAlignmentLeft
{
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

- (void) setTitleTextAlignmentCenter
{
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

- (void) setTitleTextAlignmentRight
{
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
}

@end
