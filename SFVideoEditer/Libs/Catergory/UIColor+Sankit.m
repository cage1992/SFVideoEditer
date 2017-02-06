//
//  UIColor+Sankit.m
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

#import "UIColor+Sankit.h"

@implementation UIColor (Sankit)

+ (UIColor *)randomColor
{
	return [UIColor colorWithRed:(CGFloat)random() / RAND_MAX
						   green:(CGFloat)random() / RAND_MAX
							blue:(CGFloat)random() / RAND_MAX
						   alpha:1.0f];
}

+ (UIColor *)rgbaColor:(UInt32)hexRGBA
{
    return [UIColor colorWithRed:((hexRGBA>>24)&0xFF)/255.0
                           green:((hexRGBA>>16)&0xFF)/255.0
                            blue:((hexRGBA>>8)&0xFF)/255.0
                           alpha:((hexRGBA)&0xFF)/255.0];
}


+ (UIColor *)colorWithHexString:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    else if ([cString length] > 8)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    NSString *aString = @"FF";
    if ([cString length] == 8) {
        range.location = 6;
        aString = [cString substringWithRange:range];
    }
    
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}



- (UIColor *)brightnessIncreased:(CGFloat)percent
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        if (percent > 0) {
            r = r + (1.0 - r) * percent;
            g = g + (1.0 - g) * percent;
            b = b + (1.0 - b) * percent;
        } else {
            r = r * (1.0 + percent);
            g = g * (1.0 + percent);
            b = b * (1.0 + percent);
        }

        return [UIColor colorWithRed:MAX(MIN(r, 1.0), 0.0)
                               green:MAX(MIN(g, 1.0), 0.0)
                                blue:MAX(MIN(b, 1.0), 0.0)
                               alpha:a];
    }
    return nil;
}
@end
