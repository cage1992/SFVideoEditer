//
//  NSMutableDictionary+Sankit.m
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

#import "NSMutableDictionary+Sankit.h"
#import "SankitFactory.h"

@implementation NSMutableDictionary (Sankit)

- (BOOL)containsKey:(NSString *)key
{
    if( self.count <= 0 || [self allKeys].count <= 0 )
        return NO;
    
    return [[self allKeys] containsObject:key];
}

+ (NSMutableDictionary *)fromJSONString:(NSString *)jsonString
{
    if(nil == jsonString) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Argument was be nil"
                                     userInfo:nil];
    }
    NSUInteger length = [jsonString length];
    NSData *data = [NSData dataWithBytes:[jsonString cStringUsingEncoding:NSStringEncodingConversionAllowLossy]
                                  length:length];
    return [NSMutableDictionary fromJSONData:data];
}

+ (NSMutableDictionary *)fromJSONData:(NSData *)jsonData
{
    return (NSMutableDictionary *)[SankitFactory parseWithJSONData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                      mustBeOfSubclass:[NSDictionary class]];
}

- (NSString *)toJSONString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (id)objectForKey:(id)key withDefault:(id)defaultValue
{
    if ([self objectForKey:key]) {
        return [self objectForKey:key];
    } else {
        return defaultValue;
    }
}

- (void)setDouble:(double)doubleValue forKey:(id)key
{
	[self setObject:[NSNumber numberWithDouble:doubleValue] forKey:key];
}

- (void)setInteger:(NSInteger)intValue forKey:(id)key
{
	[self setObject:[NSNumber numberWithInteger:intValue] forKey:key];
}

- (void)setBool:(BOOL)boolValue forKey:(id)key
{
	[self setObject:[NSNumber numberWithBool:boolValue] forKey:key];
}

- (void)setObjectMaybeNil:(id)object forKey:(id)key
{
	if (!object) object = [NSNull null];
	[self setObject:object forKey:key];
}

@end
