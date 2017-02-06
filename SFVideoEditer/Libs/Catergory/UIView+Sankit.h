//
//  SHelperView.h
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

typedef enum
{
	UIViewBorderSideTop 	= 0,
    UIViewBorderSideRight 	= 1,
    UIViewBorderSideBottom 	= 2,
    UIViewBorderSideLeft 	= 3
} UIViewBorderSide;


typedef enum
{
	UIViewHorizontalAlignmentCenter = 0,
	UIViewHorizontalAlignmentLeft 	= 1,
	UIViewHorizontalAlignmentRight 	= 2
} UIViewHorizontalAlignment;

typedef enum
{
	UIViewVerticalAlignmentMiddle = 0,
	UIViewVerticalAlignmentTop 	  = 1,
	UIViewVerticalAlignmentBottom = 2
} UIViewVerticalAlignment;



@interface UIView (Sankit)

#pragma mark - Init round cornerd view
- (id)initWithRoundFrame:(CGRect)frame radius:(CGFloat)radius;
- (id)initWithRoundFrame:(CGRect)frame radius:(CGFloat)radius borderColor: (UIColor *)color;


#pragma mark - View properties and alignments
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment;
- (void)alignVertically: (UIViewVerticalAlignment)verticalAlignment;
- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
               vertically: (UIViewVerticalAlignment)verticalAlignment;



#pragma mark - center "self" reletive to "view"
- (void)centerWithRespectToView:(UIView *)view;
- (void)centerHorizontallyWithRespectToView:(UIView *)view;
- (void)centerVerticallyWithRespectToView:(UIView *)view;

- (void)setBackgroundImageWithName:(NSString*)imageName;



#pragma mark - Add borders to View
/**
 * 给 view 添加宽度为 .5 的边，并将颜色设为 color
 */
- (void)setBorderColor:(UIColor *)color;

/**
 * 给 view 添加宽度为 width 的边，并将颜色设为 color
 */
- (void)setBorderWithColor:(UIColor *)color width:(CGFloat)width;

/**
 * 给 view 上侧添加宽度为 .5 的边，并将颜色设为 color
 */
- (void)setBorderTopColor:(UIColor *)color;

/**
 * 给 view 上侧添加宽度为 width 的边，并将颜色设为 color
 */
- (void)setBorderTopColor:(UIColor *)color andWidth:(CGFloat)width;

/**
 * 给 view 右侧添加宽度为 .5 的边，并将颜色设为 color
 */
- (void)setBorderRightColor:(UIColor *)color;

/**
 * 给 view 右侧添加宽度为 width 的边，并将颜色设为 color
 */
- (void)setBorderRightColor:(UIColor *)color andWidth:(CGFloat)width;

/**
 * 给 view 下侧添加宽度为 .5 的边，并将颜色设为 color
 */
- (void)setBorderBottomColor:(UIColor *)color;

/**
 * 给 view 下侧添加宽度为 width 的边，并将颜色设为 color
 */
- (void)setBorderBottomColor:(UIColor *)color andWidth:(CGFloat)width;

/**
 * 给 view 左侧添加宽度为 .5 的边，并将颜色设为 color
 */
- (void)setBorderLeftColor:(UIColor *)color;

/**
 * 给 view 左侧添加宽度为 width 的边，并将颜色设为 color
 */
- (void)setBorderLeftColor:(UIColor *)color andWidth:(CGFloat)width;

- (void)setBorderType:(UIViewBorderSide)type andColor:(UIColor *)color andWidth:(CGFloat)width;



#pragma mark - Set view background gradients
- (void)setGradient:(NSArray *)colors withOpacity:(CGFloat)opacity;

/**
 * 给 view 添加水平方向渐变的背景颜色
 * @param: colors 颜色数组.
 * @param: opacity 透明度.
 */
- (void)setHorizentalGradient:(NSArray *)colors withOpacity:(CGFloat)opacity;

/**
 * 给 view 添加水平方向从 from 渐变到 to 的背景颜色. 透明度为 opacity.
 */
- (void)setHorizentalGradientFromColor:(UIColor*)from toColor:(UIColor*)to withOpacity:(CGFloat)opacity;


#pragma mark - Shift views
/**
 * 将 view 垂直方向移动 points 像素.
 * points>0, 下移; points<0, 上移
 */
- (void)shiftVertically:(CGFloat)points;

/**
 * 将 view 水平方向移动 points 像素.
 * points>0, 右移; points<0, 左移
 */
- (void)shiftHorizontally:(CGFloat)points;


#pragma mark - View show/hide animations
- (void)animateRightToLeft;
- (void)animateLeftToRight;
- (void)animateFromPoint:(CGPoint)from to:(CGPoint)to duration:(CGFloat)duration;
- (void)animateUpFromParentWithDuration:(CGFloat)duration;
- (void)animateDownFromParentWithDuration:(CGFloat)duration;

/**
 * 逐渐显示 view
 * alpha 从 0 过渡到 1.
 */
- (void)fadeIn;

- (void)fadeInWithCompletion:(void (^)(BOOL finished))completion;

/**
 * 用 duration (秒)时间逐渐显示 view.
 * alpha 从 0 过渡到 1.
 */
- (void)fadeInWithDuration:(float)duration;

- (void)fadeInWithDuration:(float)duration completion:(void (^)(BOOL finished))completion;

/**
 * 逐渐隐藏 view
 * alpha 从 1 过渡到 0.
 */
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)(BOOL finished))completion;

/**
 * 用 duration (秒)时间逐渐隐藏 view. 
 * alpha 从 1 过渡到 0.
 */
- (void)fadeOutWithDuration:(float)duration;

/**
 * 用 duration (秒)时间逐渐隐藏 view, 完成后执行 completion.
 * alpha 从 1 过渡到 0.
 */
- (void)fadeOutWithDuration:(float)duration completion:(void (^)(BOOL finished))completion;

/**
 * 用 duration (秒)时间逐渐隐藏 view, 完成后将其从父 view 中移除
 * alpha 从 1 过渡到 0.
 */
- (void)fadeOutAndRemove;

/**
 * 隐藏. 即将 alpha 设为 0.
 */
- (void)hide;

/**
 * 隐藏并从父view中将自己移除
 */
- (void)hideAndRemove;

/**
 * 显示. 即将 alpha 设为 1.
 */
- (void)show;

+ (void)fadeViews:(NSArray *)views withDuration:(float)duration fadeIn:(BOOL)fadeIn completion:(void (^)(BOOL finished))completion;

#pragma mark - Others

/**
 * 将 view 转化为 UIImage
 */
- (UIImage *)imageRepresentation;

/**
 * 移除所有子 view
 */
- (void)removeAllSubviews;

/**
 * 查找(键盘)焦点 view, 如输入框.
 */
- (UIView *)findFirstResponder;

/**
 * 给 view 添加 3 像素的圆角
 */
- (void)addCornerRadius;

/**
 * 给 view 添加 radius 个像素的圆角
 */
- (void)addCornerRadius:(CGFloat)radius;

@end
