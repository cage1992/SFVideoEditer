//
//  UIImage+SHelperImage.h
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

#import <UIKit/UIKit.h>

@interface UIImage (Sankit)

#pragma mark Return @2x image
+ (UIImage *) imageNamed2x: (NSString *) name;

#pragma mark - image and color
/**
 * 返回由颜色生成的图片
 */
+ (UIImage *) imageWithColor:(UIColor *)color;

/**
 * 用颜色 color 渲染的名称为 name 的图片
 */
+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;


#pragma mark - resizing
- (UIImage *)resizeToWidth:(CGFloat)width;

#pragma mark 缩放到指定的最大宽度和高度(保持比例)
/**
 * 保持比例缩放到宽度 width 和高度 height.
 * 如: 1000*2000 的图缩放到 width:500, height:500 时后,
 * 大小实际为 250*500.
 */
- (UIImage *)resizeToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 * 保持比例缩放到宽度 newSize.width 和高度 newSize.height.
 * 如: 1000*2000 的图缩放到 width:500, height:500 时后,
 * 大小实际为 250*500.
 */
- (UIImage *)resizeToMaxSize:(CGSize)newSize;

+ (UIImage *) imageFromView:(UIView *)view;
+ (UIImage *) blankWithWidth:(CGFloat)width andHeight:(CGFloat)height;


#pragma mark 待测试
- (UIImage *)scaleToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)src scaledToSizeWithAspectRatio:(CGSize)targetSize;
- (UIImage *)resizeToSize:(CGSize)newSize thenCropWithRect:(CGRect)cropRect;

@end
