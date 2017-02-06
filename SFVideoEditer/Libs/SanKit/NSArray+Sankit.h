//
//  NSArray+Sankit.h
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

@interface NSArray (Sankit)

/**
 * 数组第一个元素
 */
- (id)firstObject;

/**
 * 数组最后一个元素
 */
- (id)lastObject;

/**
 * 在数组后面追加数组 arr
 */
- (NSArray *)appendArray:(NSArray *)arr;

/**
 * 安全返回数组元素. 不存在时返回 nil, 防止崩溃
 */
- (id)safeObjectAtIndex:(NSInteger)index;

/**
 * 返回数组第 index 元素. 不存在时返回缺省值 defaultValue, 防止崩溃
 */
- (id)objectAtIndex:(NSInteger)index withDefault:(id)defaultValue;

- (NSArray *)subarrayFromIndex:(NSUInteger)index;
/**
 * 返回从 0 到 index 位置的子数组
 */
- (NSArray *)subarrayToIndex:(NSUInteger)index;

+ (NSArray *)fromJSONData:(NSData *)jsonData;

/**
 * 由 jsonString 解码出的数组
 */
+ (NSArray *)fromJSONString:(NSString *)jsonString;

/**
 * 将数组编码为 json 字符串
 */
- (NSString *)toJSONString;

/**
 * 将数组元素顺序随机化
 */
- (NSArray *)arrayShuffled;

/**
 * 将数组元素顺序倒序排列
 */
- (NSArray *)arrayReversed;

/**
 * 随机返回数组中一个元素
 */
- (id)randomObject;

/**
 * 移除数组中重复的元素
 */
- (instancetype)unique;

@end
