//
//  NSTimer+Sankit.m
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

#import "NSTimer+Sankit.h"

@implementation NSTimer (Sankit)

+ (void)executeBlock:(NSTimer *)timer
{
    if([timer userInfo]){
        void (^block)() = (void (^)())[timer userInfo];
        block();
    }
}

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval andBlock:(void (^)())block
{
    return [self timerRepeats:NO withTimeInterval:timeInterval andBlock:block];
}

+ (instancetype)timerRepeats:(BOOL)repeats withTimeInterval:(NSTimeInterval)timeInterval andBlock:(void (^)())block
{
    void (^_block)() = [block copy];
    id timer = [self timerWithTimeInterval:timeInterval
                                    target:self
                                  selector:@selector(executeBlock:)
                                  userInfo:_block
                                   repeats:repeats];
    return timer;
}

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval andBlock:(void (^)())block
{
    return [self scheduledTimerRepeats:NO withTimeInterval:timeInterval andBlock:block];
}

+ (instancetype)scheduledTimerRepeats:(BOOL)repeats withTimeInterval:(NSTimeInterval)timeInterval andBlock:(void (^)())block
{
    void (^_block)() = [block copy];
    id timer = [self scheduledTimerWithTimeInterval:timeInterval
                                             target:self
                                           selector:@selector(executeBlock:)
                                           userInfo:_block
                                            repeats:repeats];
    return timer;
}

@end
