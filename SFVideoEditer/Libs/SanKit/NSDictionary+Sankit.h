//
//  NSDictionary+Sankit.h
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

#import <Foundation/Foundation.h>

@interface NSDictionary (Sankit)

- (BOOL)containsKey:(NSString *)key;

#pragma mark - JSON serialization/unserialization
+ (NSDictionary *)fromJSONData:(NSData *)jsonData;
+ (NSDictionary *)fromJSONString:(NSString *)jsonString;
- (NSString *)toJSONString;

#pragma mark - Get value
- (id)objectForKey:(id)aKey withDefault:(id)defaultValue;

/**
 * 将 key 对应的值返回成字符串.
 */
- (NSString *)stringForKey:(id)key;

/**
 * 将 key 对应的值返回成字符串. 不存在时返回 defaultValue.
 */
- (NSString *)stringForKey:(id)key withDefault:(NSString *)defaultValue;

/**
 * 将 key 对应的值返回成浮点数.
 */
- (double)doubleForKey:(id)key;

/**
 * 将 key 对应的值返回成浮点数. 不存在时返回 defaultValue.
 */
- (double)doubleForKey:(id)key withDefault:(double)defaultValue;

/**
 * 将 key 对应的值返回成整数.
 */
- (NSInteger)integerForKey:(id)key;

/**
 * 将 key 对应的值返回成整数. 不存在时返回 defaultValue.
 */
- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)defaultValue;

/**
 * 将 key 对应的值返回成无符号整数.
 */
- (NSUInteger)unsignedIntegerForKey:(id)key;

/**
 * 将 key 对应的值返回成无符号整数. 不存在时返回 defaultValue.
 */
- (NSUInteger)unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue;

/**
 * 将 key 对应的值返回成 NSNumber.
 */
- (NSNumber *)numberForKey:(id)key;

/**
 * 将 key 对应的值返回成 NSNumber. 缺省值为整数 defaultValue.
 */
- (NSNumber *)numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue;

/**
 * 将 key 对应的值返回成 NSNumber. 缺省值为双精度值 defaultValue.
 */
- (NSNumber *)numberForKey:(id)key withDefaultDouble:(double)defaultValue;

/**
 * 将 key 对应的值返回成布尔值.
 */
- (BOOL)boolForKey:(id)key;

/**
 * 将 key 对应的值返回成布尔值. 不存在时返回 defaultValue.
 */
- (BOOL)boolForKey:(id)key withDefault:(BOOL)defaultValue;

/**
 * 将 key 对应的值返回成布尔 NSNumber.
 */
- (NSNumber *)boolValueForKey:(id)key;

/**
 * 将 key 对应的值返回成 NSNumber. 不存在时返回 defaultValue.
 */
- (NSNumber *)boolValueForKey:(id)key withDefault:(BOOL)defaultValue;

/**
 * 将 key 对应的值返回成日期.
 */
- (NSDate *)dateForKey:(id)key;

/**
 * 将 key 对应的值返回成日期. 不存在时返回 defaultValue.
 */
- (NSDate *)dateForKey:(id)key withDefault:(NSDate *)defaultDate;

+ (NSDictionary *)parseQueryString:(NSString *)query;

@end
