//
//  NSNumber+Sankit.m
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

#import "NSNumber+Sankit.h"

@implementation NSNumber (Sankit)

- (BOOL)compare:(NSNumber *)number comparisonResult:(NSComparisonResult)comparisonResult
{
    if (!number) {
        number = @0;
    }
    
    if (![number isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    
    return [self compare:number] == comparisonResult;
}

- (BOOL)isGreaterThan:(NSNumber *)number
{
    return [self compare:number comparisonResult:NSOrderedDescending];
}

- (BOOL)isLessThan:(NSNumber *)number
{
    return [self compare:number comparisonResult:NSOrderedAscending];
}

- (BOOL)isGreaterThanOrEqualTo:(NSNumber *)number
{
    return ![self isLessThan:number];
}

- (BOOL)isLessThanOrEqualTo:(NSNumber *)number
{
    return ![self isGreaterThan:number];
}

+ (NSNumberFormatter *) getFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];

    return formatter;
}

@end
