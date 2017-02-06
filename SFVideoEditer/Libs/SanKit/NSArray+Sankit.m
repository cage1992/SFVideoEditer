//
//  NSArray+Sankit.m
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

#import "NSArray+Sankit.h"
#import "SankitFactory.h"
#import "NSMutableArray+Sankit.h"

@implementation NSArray (Sankit)

- (id)firstObject
{
    if (self && self.count > 0) {
        return [self objectAtIndex:0];
    }
    
    return nil;
}

- (id)lastObject
{
    if (self && self.count > 0) {
        return [self objectAtIndex:self.count-1];
    }
    
    return nil;
}

- (NSArray *)appendArray:(NSArray *)arr
{
    if (!arr) {
        return self;
    }
    
    NSMutableArray *array = [self copy];
    [array addObjectsFromArray:arr];
    return array;
}

- (id)safeObjectAtIndex:(NSInteger)index
{
    if(index >= self.count)
        return nil;
    return self[index];
}

- (id)objectAtIndex:(NSInteger)index withDefault:(id)defaultValue
{
    if (index >= 0 && index < [self count])
        return [self objectAtIndex:index];
    
    return defaultValue;
}

- (NSArray *)subarrayFromIndex:(NSUInteger)index
{
    NSRange range = {index, [self count] - index};
    return [self subarrayWithRange:range];
    
}

- (NSArray *)subarrayToIndex:(NSUInteger)index
{
    NSRange range = {0, index};
    return [self subarrayWithRange:range];
}



+ (NSArray *)fromJSONData:(NSData *)jsonData
{
    return (NSArray *)[SankitFactory parseWithJSONData:jsonData options:0 mustBeOfSubclass:[NSArray class]];
}

+ (NSArray *)fromJSONString:(NSString *)jsonString
{
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSArray fromJSONData:data];
}

- (NSString *)toJSONString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (NSArray *)arrayShuffled
{
    NSMutableArray *array = [self mutableCopy];
    [array shuffle];
    return array;
}

- (NSArray *)arrayReversed
{
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	for(id obj in [self reverseObjectEnumerator]) {
		[array addObject:obj];
	}
	return array;
}

- (id)randomObject
{
	if ([self count] == 0) return nil;
    NSUInteger count = [self count];
    NSAssert(count <= UINT32_MAX, @"Array size is greater than rand supports");
	NSUInteger index = arc4random_uniform((int32_t)count);
	return [self objectAtIndex:index];
}

- (instancetype)unique
{
    NSMutableArray *uniqueObjects = [NSMutableArray new];
    for(id obj in self) {
        if([uniqueObjects containsObject:obj] == NO) {
            [uniqueObjects addObject:obj];
        }
    }
    return uniqueObjects;
}

@end
