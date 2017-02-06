//
//  NSDate+Sankit.m
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

#import "NSDate+Sankit.h"

#define NSGregorianCalendar NSCalendarIdentifierGregorian
#define GregorianCalendar NSGregorianCalendar

@implementation NSDate (Sankit)

+ (NSDate *)dateFromTimestamp:(NSNumber *)timestamp
{
    long long correctedTimestamp = [timestamp floatValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:correctedTimestamp];
    return date;
}

+ (NSString *)stringFromTimestamp:(NSNumber *)timestamp
{
    return [self stringFromTimestamp:timestamp dateFormat:@"M/d/YY"];
}

+ (NSString *)timeStringFromTimestamp:(NSNumber *)timestamp
{
    return [self stringFromTimestamp:timestamp dateFormat:@"M/d/yy h:mm a"];
}

+ (NSString *)monthDateStringFromTimestamp:(NSNumber *)timestamp
{
    return [self stringFromTimestamp:timestamp dateFormat:@"MMMM y"];
}

+ (NSString *)stringFromTimestamp:(NSNumber *)timestamp dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    long long correctedTimestamp = [timestamp floatValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:correctedTimestamp];
    return [formatter stringFromDate:date];
}

- (NSString *)stringWithReadableTimeDifference
{
    
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    
    int secondsInADay = 3600*24;
    int secondsInAYear = 3600*24*365;
    int yearsDiff = fabs(timeInterval/secondsInAYear);
    int daysDiff = fabs(timeInterval/secondsInADay);
    int hoursDiff = fabs((fabs(timeInterval) - (daysDiff * secondsInADay)) / 3600);
    int minutesDiff = fabs((fabs(timeInterval) - ((daysDiff * secondsInADay) + (hoursDiff * 60))) / 60);
    
    NSString *positivity = [NSString stringWithFormat:@"%@", NSLocalizedString(@"ago", @"")];
    
    if (yearsDiff > 1)
        return [NSString stringWithFormat:@"%d %@ %@", yearsDiff, NSLocalizedString(@"years", @""), positivity];
    else if (yearsDiff == 1)
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"a year", @""), positivity];
    
    if (daysDiff > 0) {
        if (hoursDiff == 0)
            return [NSString stringWithFormat:@"%d %@ %@", daysDiff, daysDiff == 1 ? NSLocalizedString(@"day", @""):NSLocalizedString(@"days", @""), positivity];
        else
            return [NSString stringWithFormat:@"%d %@ %@", daysDiff, daysDiff == 1 ? NSLocalizedString(@"day", @""):NSLocalizedString(@"days", @""), positivity];
    }
    else {
        if (hoursDiff == 0) {
            if (minutesDiff == 0)
                return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"a few seconds", @""), positivity];
            else
                return [NSString stringWithFormat:@"%d %@ %@", minutesDiff, minutesDiff == 1 ? NSLocalizedString(@"minute", @""):NSLocalizedString(@"minutes", @""), positivity];
        }
        else {
            if (hoursDiff == 1)
                return [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"about", @""), NSLocalizedString(@"an hour", @""), positivity];
            else
                return [NSString stringWithFormat:@"%d %@ %@", hoursDiff, NSLocalizedString(@"hours", @""), positivity];
        }
    }
}

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

- (NSString *)dateToString
{
    return [self dateToStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)dateToStringWithDateFormat:(NSString *)dateFormat
{
    return [self dateToStringWithDateFormat:dateFormat timezone:nil];
}

- (NSString *)dateToStringWithDateFormat:(NSString *)dateFormat timezone:(NSTimeZone *)timezone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    if (timezone) {
        [formatter setTimeZone:timezone];
    }
    return [formatter stringFromDate:self];
}

+ (NSString *)currentDateString
{
    return [self stringFromTimestamp:[self currentTimestamp]
                          dateFormat:@"M/d/YY"];
}

+ (NSNumber *)currentTimestamp
{
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSNumber numberWithLongLong:timestamp];
}

+ (NSInteger)currentYear
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear
                                                fromDate:[NSDate date]];
    return [components year];
}

+ (NSInteger)yearFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:date];
    return [components year];
}

+ (NSInteger)monthFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:date];
    return [components month];
}

+ (NSInteger)yearFromTimestamp:(NSNumber *)timestamp
{
    return [self yearFromDate:[NSDate dateFromTimestamp:timestamp]];
}

+ (NSInteger)monthFromTimestamp:(NSNumber *)timestamp
{
    return [self monthFromDate:[self dateFromTimestamp:timestamp]];
}

- (NSDate *)dateByOffsetMonths:(NSUInteger)months
                          days:(NSUInteger)days
                         hours:(NSUInteger)hours
                       minutes:(NSUInteger)minutes
                       seconds:(NSUInteger)seconds
{
    NSDateComponents *components = [NSDateComponents new];
    NSCalendar *calender = [NSCalendar currentCalendar];
    components.month = months;
    components.day = days;
    components.hour = hours;
    components.minute = minutes;
    components.second = seconds;
    return [calender dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)beginningOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [calendar components:NSCalendarUnitYear |
                                                        NSCalendarUnitMonth |
                                                        NSCalendarUnitDay
                                               fromDate:self];

    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [NSDateComponents new];
    components.day = 1;

    NSDate *date = [calendar dateByAddingComponents:components
                                             toDate:self.beginningOfDay
                                            options:0];

    date = [date dateByAddingTimeInterval:-1];

    return date;
}

@end
