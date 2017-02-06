//
//  SHelperView.m
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

#import "UIView+Sankit.h"
#import "UIColor+Sankit.h"
//#import "SFMacro.h"

@implementation UIView (Sankit)

#pragma mark - Init methods
- (id)initWithRoundFrame:(CGRect)frame radius:(CGFloat)radius
{
    return [self initWithRoundFrame:frame radius:radius borderColor:[UIColor clearColor]];
}


- (id)initWithRoundFrame:(CGRect)frame radius:(CGFloat)radius borderColor: (UIColor *)color
{
    self = [self initWithFrame:frame];
    if (self) {
        CALayer *layer = self.layer;
        layer.borderWidth = .5f;
        layer.borderColor = color.CGColor;
        layer.cornerRadius = radius;
        layer.masksToBounds = YES;
    }
    return self;
}


#pragma mark - Properties

- (CGFloat)width
{
	return self.bounds.size.width;
}

- (void)setWidth: (CGFloat)width
{
	// Changing the width of a view through its bounds updates the view's x origin so it needs to be set again after the the bounds have been changed.
	CGFloat previousXOrigin = self.originX;
    
	CGRect viewBounds = self.bounds;
    
	// Floor the width to avoid subpixel rendering.
	viewBounds.size.width = floorf(width);
    
	self.bounds = viewBounds;
    
	self.originX = previousXOrigin;
}

- (CGFloat)height
{
	return self.bounds.size.height;
}

- (void)setHeight: (CGFloat)height
{
	// Changing the height of a view through its bounds updates the view's y origin
    // so it needs to be set again after the the bounds have been changed.
	CGFloat previousYOrigin = self.originY;
    
	CGRect viewBounds = self.bounds;
    
	// Floor the height to avoid subpixel rendering.
	viewBounds.size.height = floorf(height);
    
	self.bounds = viewBounds;
    
	self.originY = previousYOrigin;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGFloat)left
{
    return [self originX];
}

- (void)setLeft:(CGFloat)left
{
    [self setOriginX:left];
}

- (CGFloat)top
{
    return [self originY];
}

- (void)setTop:(CGFloat)top
{
    [self setOriginY:top];
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight:(CGFloat)right
{
	CGPoint viewCenter = self.center;
    
	// Floor right value to avoid subpixel rendering.
	viewCenter.x = floor(right) - (self.width / 2.0f);
    
	self.center = viewCenter;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
	CGPoint viewCenter = self.center;
    
	// Floor bottom value to avoid subpixel rendering.
	viewCenter.y = floor(bottom) - (self.height / 2.0f);
    
	self.center = viewCenter;
}

- (CGFloat)originX
{
	return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX
{
	CGPoint viewCenter = self.center;
    
	// Floor originX to avoid subpixel rendering.
	viewCenter.x = floor(originX) + (self.width / 2.0f);
    
	self.center = viewCenter;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY
{
	CGPoint viewCenter = self.center;
    
	// Floor originY to avoid subpixel rendering.
	viewCenter.y = floorf(originY) + (self.height / 2.0f);
    
	self.center = viewCenter;
}

- (CGFloat)centerX
{
	return self.center.x;
}

- (void)setCenterX:(CGFloat)xCenter
{
	CGPoint center = self.center;
    
	// Calculate the x origin of the view around the new center point and floor it
    // to avoid the sub pixel rendering that will occur if the width is an odd number.
	CGFloat xOrigin = floorf(xCenter - (self.width / 2.0f));
    
	center.x = xOrigin + (self.width / 2.0f);
    
	self.center = center;
}

- (CGFloat)centerY
{
	return self.center.y;
}

- (void)setCenterY:(CGFloat)yCenter
{
	CGPoint center = self.center;
    
	// Calculate the y origin of the view around the new center point and floor it
    // to avoid the sub pixel rendering that will occur if the height is an odd number.
	CGFloat yOrigin = floorf(yCenter - (self.height / 2.0f));
    
	center.y = yOrigin + (self.height / 2.0f);
    
	self.center = center;
}

// private method
- (void)_setPixelSnappedCenter:(CGPoint)center
{
	// Calculate the x origin of the view around the new center point and floor it
    // to avoid the sub pixel rendering that will occur if the width is an odd number.
	CGFloat xOrigin = floorf(center.x - (self.width / 2.0f));
    
	// Calculate the y origin of the view around the new center point and floor it
    // to avoid the sub pixel rendering that will occur if the height is an odd number.
	CGFloat yOrigin = floorf(center.y - (self.height / 2.0f));
    
	// Calculate the new center of the view around the floored x and y origins.
	center.x = xOrigin + (self.width / 2.0f);
	center.y = yOrigin + (self.height / 2.0f);
    
	self.center = center;
}

// private method
- (void)_setPixelSnappedFrame:(CGRect)frame
{
	// Floor the width and height of the frame to avoid subpixel rendering.
	CGRect bounds = CGRectMake(0.0f, 0.0f, floorf(frame.size.width), floorf(frame.size.height));
    
	// Floor the x and y origin of the frame to avoid subpixel rendering.
	CGPoint center = CGPointZero;
	center.x = floor(frame.origin.x) + (bounds.size.width / 2.0f);
	center.y = floorf(frame.origin.y) + (bounds.size.height / 2.0f);
    
	self.bounds = bounds;
	self.center = center;
}

- (void)alignHorizontally:(UIViewHorizontalAlignment)horizontalAlignment
{
	if (self.superview == nil) {
		return;
	}
    
	switch (horizontalAlignment) {
		case UIViewHorizontalAlignmentCenter: {
			self.originX = (self.superview.width - self.width) / 2.0f;
			break;
		}
            
		case UIViewHorizontalAlignmentLeft: {
			self.originX = 0.0f;
			break;
		}
            
		case UIViewHorizontalAlignmentRight: {
			self.originX = self.superview.width - self.width;
			break;
		}
	}
}

- (void)alignVertically:(UIViewVerticalAlignment)verticalAlignment
{
	if (self.superview == nil) {
		return;
	}
    
	switch (verticalAlignment) {
		case UIViewVerticalAlignmentMiddle: {
			self.originY = (self.superview.height - self.height) / 2.0f;
			break;
		}
            
		case UIViewVerticalAlignmentTop: {
			self.originY = 0.0;
			break;
		}
            
		case UIViewVerticalAlignmentBottom: {
			self.originY = self.superview.height - self.height;
			break;
		}
	}
}

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
               vertically: (UIViewVerticalAlignment)verticalAlignment
{
	if (self.superview == nil) {
		return;
	}
    
	CGFloat xOrigin = 0.0f;
	CGFloat yOrigin = 0.0f;
    
	switch (horizontalAlignment) {
		case UIViewHorizontalAlignmentCenter: {
			xOrigin = (self.superview.width - self.width) / 2.0f;
			break;
		}
            
		case UIViewHorizontalAlignmentLeft: {
			xOrigin = 0.0f;
			break;
		}
            
		case UIViewHorizontalAlignmentRight: {
			xOrigin = self.superview.width - self.width;
			break;
		}
	}
    
	switch (verticalAlignment) {
		case UIViewVerticalAlignmentMiddle: {
			yOrigin = (self.superview.height - self.height) / 2.0f;
			break;
		}
            
		case UIViewVerticalAlignmentTop: {
			yOrigin = 0.0;
			break;
		}
            
		case UIViewVerticalAlignmentBottom: {
			yOrigin = self.superview.height - self.height;
			break;
		}
	}
    
	CGRect frame = CGRectMake(xOrigin, yOrigin, self.width, self.height);
    
	[self _setPixelSnappedFrame:frame];
}

- (void)centerWithRespectToView:(UIView *)view
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}

- (void)centerHorizontallyWithRespectToView:(UIView *)view
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, frame.origin.y);
    self.frame = frame;
}

- (void)centerVerticallyWithRespectToView:(UIView *)view
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(frame.origin.x, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}

- (void) setBackgroundImageWithName:(NSString*)imageName
{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.bounds];
    bg.image = [UIImage imageNamed:imageName];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.clipsToBounds = YES;

    [self addSubview:bg];
}

#pragma mark - Border settings
- (void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = .5f;
}

- (void) setBorderTopColor:(UIColor *)color
{
    [self setBorderTopColor:color andWidth:.5f];
}

- (void)setBorderTopColor:(UIColor *)color andWidth:(CGFloat)width
{
    [self setBorderType:UIViewBorderSideTop andColor:color andWidth:width];
}

- (void)setBorderRightColor:(UIColor *)color
{
    [self setBorderRightColor:color andWidth:.5f];
}

- (void)setBorderRightColor:(UIColor *)color andWidth:(CGFloat) width
{
    [self setBorderType:UIViewBorderSideRight andColor:color andWidth:width];
}

- (void)setBorderBottomColor:(UIColor *)color
{
    [self setBorderBottomColor:color andWidth:.5f];
}

- (void)setBorderBottomColor:(UIColor *)color andWidth:(CGFloat) width
{
    [self setBorderType:UIViewBorderSideBottom andColor:color andWidth:width];
}

- (void)setBorderLeftColor:(UIColor *)color
{
    [self setBorderLeftColor:color andWidth:.5f];
}

- (void)setBorderLeftColor:(UIColor *)color andWidth:(CGFloat)width
{
    [self setBorderType:UIViewBorderSideLeft andColor:color andWidth:width];
}

- (void)setBorderWithColor:(UIColor *)color width:(CGFloat)width
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void) setBorderType:(UIViewBorderSide)type andColor:(UIColor *)color andWidth:(CGFloat)width
{
    CALayer *border = [CALayer layer];
    
    switch (type) {
        case UIViewBorderSideTop:
            border.frame = CGRectMake(0, 0, self.frame.size.width, width);
            break;
        case UIViewBorderSideRight:
            border.frame = CGRectMake(self.frame.size.width - width, 0.0f, width, self.frame.size.height);
            break;
        case UIViewBorderSideBottom:
            border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
            break;
        case UIViewBorderSideLeft:
        default:
            border.frame = CGRectMake(0, 0, width, self.frame.size.height);
            break;
    }

    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
}


- (void) setGradient:(NSArray *)colors withOpacity:(CGFloat)opacity
{
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.bounds = self.bounds;

    CGRect f = self.bounds;
    f.origin.x = 0;
    f.origin.y = 0;
    gradient.frame = f;

    gradient.colors = colors;
    gradient.opacity = opacity;

    [self.layer addSublayer:gradient];
}

- (void) setHorizentalGradient:(NSArray *)colors withOpacity:(CGFloat)opacity
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.bounds = self.bounds;
    
    CGRect f = self.bounds;
    f.origin.x = 0;
    f.origin.y = 0;
    gradient.frame = f;
    
    gradient.colors = colors;
    gradient.opacity = opacity;

    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);

    [self.layer insertSublayer:gradient atIndex:0];
}

- (void) setHorizentalGradientFromColor:(UIColor*)from toColor:(UIColor*)to withOpacity:(CGFloat)opacity
{
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.bounds = self.bounds;

    CGRect f = self.bounds;
    f.origin.x = 0;
    f.origin.y = 0;
    gradient.frame = f;

    gradient.colors = [NSArray arrayWithObjects:(id)from.CGColor, (id)to.CGColor, nil];
    gradient.opacity = opacity;

    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);

    [self.layer insertSublayer:gradient atIndex:0];
}





#pragma mark - Shift views
- (void)shiftVertically:(CGFloat)points
{
    CGRect frame = self.frame;
    frame.origin.y = self.frame.origin.y + points;
    self.frame = frame;
}

- (void)shiftHorizontally:(CGFloat)points
{
    CGRect frame = self.frame;
    frame.origin.x = self.frame.origin.x + points;
    self.frame = frame;
}


- (void)animateRightToLeft
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    [transition setSubtype:kCATransitionFromRight];
    [self.layer addAnimation:transition forKey:nil];
}

- (void)animateLeftToRight
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    [self.layer addAnimation:transition forKey:nil];
}

- (void)animateFromPoint:(CGPoint)from to:(CGPoint)to duration:(CGFloat)duration
{
    self.origin = from;
    [UIView animateWithDuration:duration animations:^{
        self.origin = to;
    }];
}

- (void)animateUpFromParentWithDuration:(CGFloat)duration
{
    [self animateFromPoint:CGPointMake(self.frame.origin.x, self.superview.height)
                        to:CGPointMake(self.frame.origin.x, self.superview.height - self.height)
                  duration:duration];
}

- (void)animateDownFromParentWithDuration:(CGFloat)duration
{
    [self animateFromPoint:CGPointMake(self.frame.origin.x, -self.height)
                        to:CGPointMake(self.frame.origin.x, 0)
                  duration:duration];
}

// Fade In
- (void)fadeIn
{
    self.alpha = 0.0f;
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{ self.alpha = 1.0; } completion:nil];
}

- (void)fadeInWithCompletion:(void (^)(BOOL finished))completion
{
    [self fadeInWithDuration:0.25 completion:completion];
}

- (void)fadeInWithDuration:(float)duration
{
    [self fadeInWithDuration:duration completion:nil];
}

- (void)fadeInWithDuration:(float)duration completion:(void (^)(BOOL finished))completion
{
    [UIView fadeViews:@[self] withDuration:duration fadeIn:YES completion:completion];
}

// Fade Out
- (void)fadeOut
{
    [self fadeOutWithDuration:0.25 completion:nil];
}

- (void)fadeOutWithCompletion:(void (^)(BOOL finished))completion
{
    [self fadeOutWithDuration:0.25 completion:completion];
}

- (void)fadeOutWithDuration:(float)duration
{
    [self fadeOutWithDuration:duration completion:nil];
}

- (void)fadeOutWithDuration:(float)duration completion:(void (^)(BOOL finished))completion
{
    [UIView fadeViews:@[self] withDuration:duration fadeIn:NO completion:completion];
}

- (void)fadeOutAndRemove
{
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)hide
{
    self.alpha = 0.0f;
}

- (void)hideAndRemove
{
    self.alpha = 0.0f;
    [self removeFromSuperview];
}

- (void)show
{
    self.alpha = 1.0f;
}

+ (void)fadeViews:(NSArray *)views withDuration:(float)duration fadeIn:(BOOL)fadeIn completion:(void (^)(BOOL finished))completion
{
    if (!views) {
        return;
    }
    
    [UIView animateWithDuration:(duration ? duration : 0.25) animations:^{
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(UIView *)obj setAlpha:(fadeIn ? 1.0 : 0.0)];
        }];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}


- (void)removeAllSubviews
{
	[self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
}

#pragma mark Returns an image representation of the view
- (UIImage *)imageRepresentation
{
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

#pragma mark - find and resign first responder
- (UIView *)findFirstResponder
{
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView * subView in self.subviews) {
        UIView * fr = [subView findFirstResponder];
        if (fr != nil)
            return fr;
    }
    
    return nil;
}

- (void) addCornerRadius
{
    [self addCornerRadius:3.f];
}

- (void)addCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}


@end
