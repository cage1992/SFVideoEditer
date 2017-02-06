//
//  STriangleView.m
//  cyh
//
//  Created by Shelley Shyan on 14-9-4.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import "SFTriangleView.h"

@interface SFTriangleView ()

@property (nonatomic, assign) CGFloat r;
@property (nonatomic, assign) CGFloat g;
@property (nonatomic, assign) CGFloat b;
@property (nonatomic, assign) CGFloat a;

@end


@implementation SFTriangleView

@synthesize r=_r, g=_g, b=_b, a=_a;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _r = _g = _b = .95;
        _a = 1;
    }
    return self;
}

- (void)fillColorRed:(CGFloat)r Green:(CGFloat)g Blue:(CGFloat)b Alpha:(CGFloat)a
{
    _r = r>1.f ? r/255.f : r;
    _g = g>1.f ? g/255.f : g;
    _b = b>1.f ? b/255.f : b;
    _a = a>1.f ? a/255.f : a;
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
    CGContextClosePath(ctx);

    CGContextSetRGBFillColor(ctx, _r, _g, _b, _a);

    CGContextFillPath(ctx);
}

@end
