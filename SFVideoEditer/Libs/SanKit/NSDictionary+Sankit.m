//
//  NSDictionary+Sankit.m
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

#import "NSDictionary+Sankit.h"
#import "SankitFactory.h"

@implementation NSDictionary (Sankit)

- (BOOL)containsKey:(NSString *)key
{
    if( self.count <= 0 || [self allKeys].count <= 0 )
        return NO;
    
    return [[self allKeys] containsObject:key];
}

+ (NSDictionary *)fromJSONData:(NSData *)jsonData
{
    return (NSDictionary *)[SankitFactory parseWithJSONData:jsonData
                                                        options:0
                                               mustBeOfSubclass:[NSDictionary class]];
}

+ (NSDictionary *)fromJSONString:(NSString *)jsonString
{
    if (!jsonString || jsonString.length == 0)
        return nil;
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return dictionary;
}

- (NSString *)toJSONString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (id)objectForKey:(id)key withDefault:(id)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return value;
}

- (NSString *)stringForKey:(id)key
{
	return [self stringForKey:key withDefault:@""];
}

- (NSString *)stringForKey:(id)key withDefault:(NSString *)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [NSString stringWithFormat:@"%@", value];
}

- (double)doubleForKey:(id)key
{
	return [self doubleForKey:key withDefault:0.0];
}

- (double)doubleForKey:(id)key withDefault:(double)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value doubleValue];
}

- (NSInteger)integerForKey:(id)key
{
	return [self integerForKey:key withDefault:0];
}

- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value integerValue];
}

- (NSUInteger)unsignedIntegerForKey:(id)key
{
	return [self unsignedIntegerForKey:key withDefault:0];
}

- (NSUInteger)unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value unsignedIntegerValue];
}

- (NSNumber *)numberForKey:(id)key
{
    id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return nil;
    NSAssert([value isKindOfClass:[NSNumber class]], @"Value not a NSNumber");
	return value;
}

- (NSNumber *)numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithInteger:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value not a NSNumber");
	return value;
}

- (NSNumber *)numberForKey:(id)key withDefaultDouble:(double)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithDouble:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value not a NSNumber");
	return value;
}

- (BOOL)boolForKey:(id)key
{
	return [self boolForKey:key withDefault:NO];
}

- (BOOL)boolForKey:(id)key withDefault:(BOOL)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value boolValue];
}

- (NSNumber *)boolValueForKey:(id)key
{
	return [self boolValueForKey:key withDefault:NO];
}

- (NSNumber *)boolValueForKey:(id)key withDefault:(BOOL)defaultValue
{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithBool:defaultValue];
	return [NSNumber numberWithBool:[value boolValue]];
}

- (NSDate *)dateForKey:(id)key
{
    return [self dateForKey:key withDefault:nil];
}

- (NSDate *)dateForKey:(id)key withDefault:(NSDate *)defaultDate
{
    id value = [self objectForKey:key];
    if (!value || [value isEqual:[NSNull null]]) return defaultDate;
    return value;
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];

    if (pairs.count < 1) {
        return dic;
    }

    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count < 2) continue;

        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [dic setObject:val forKey:key];
    }
    return dic;
}

@end
