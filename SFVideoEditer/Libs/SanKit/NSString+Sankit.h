//
//  NSString+Sankit.h
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

@interface NSString (Sankit)

- (BOOL)isEmpty;
- (NSString *)md5;
- (NSString *)trim;

- (BOOL)beginWith:(NSString *)prefix;
- (BOOL)endWith:(NSString *)suffix;
- (BOOL)contains:(NSString *)string;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (NSString *)stringBetweenString:(NSString *)start andString:(NSString *)end;

/**
 * 检查字符串是不是合法的邮件格式
 */
- (BOOL)isEmail;
/**
 * 检查字符串是不是纯数字
 */
- (BOOL)isNumber;

/**
 * 是否是合法的手机号格式. 仅中国适用
 */
- (BOOL)isMobile;

- (BOOL)isUserName; // [a-z0-9] only
- (BOOL)isFloatNumber;

/**
 * 日期字符串是否是将来的日期
 */
- (BOOL)isFutureDate;

/**
 * 将日期字符串转化为时间戳
 */
- (NSUInteger)toTimestamp;

/**
 * 将标准日期字符串转化为 format 格式字符串.
 * 如: 2015-02-24 13:23:34 转为 HH:mm 格式后为 13:23
 */
- (NSString *)toDateStringWithFormat:(NSString *)format;

- (NSDate *)toDateWithFormat:(NSString *)formatString;

/**
 * 比较两个日期字符串的时间差(秒)
 */
+ (NSInteger)dateDiffInSeconds:(NSString *)origDate;

+ (NSString *)randomStringWithLength:(NSUInteger)length noNumbers:(BOOL)noNumbers;

#pragma mark - HTML entity encoding/decoding
- (NSString *)decodeHtmlEntities;
- (NSString *)encodeHtmlEntities;

#pragma mark - URL encoding/decoding
- (NSString *)stringWithURLQueryEscaped;
- (NSString *)stringWithURLQueryUnescaped;
- (NSString *)getURLQuery:(NSString *)queryName;
- (NSString *)setURLQuery:(NSString *)queryName value:(NSString*)queryValue;

#pragma mark - String sizes
#pragma mark One line
- (CGSize)computeSizeWithFont:(UIFont *)font;

#pragma mark Multiple lines
- (CGFloat)computeWidthWithFont:(UIFont *)font height:(CGFloat)height;

#pragma mark Multiple lines
- (CGFloat)computeHeightWithFont:(UIFont *)font width:(CGFloat)width;

/* 将url字符串转成utf8兼容的URL */
- (NSURL *)stringToURL;

/* 将utf8兼容的URL转成字符串 */
+ (NSString *)stringFromURL:(NSURL *)url;

@end
