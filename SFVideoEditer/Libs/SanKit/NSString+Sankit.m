//
//  NSString+Sankit.m
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

#import "NSString+Sankit.h"
#import "NSDate+Sankit.h"
#import "NSDictionary+Sankit.h"
#import "SFMacro.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Sankit)

- (BOOL)isEmpty
{
    if (self == NULL || self == nil) {
        return YES;
    }
    
    if([self length] == 0) {
        return YES;
    }
    
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)md5
{
    const char *cstr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cstr, (unsigned int)strlen(cstr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - String contains
- (BOOL)beginWith:(NSString *)prefix {
    NSRange	range	= [self rangeOfString:prefix];
    return (NSNotFound != range.location && range.location == 0);
}

- (BOOL)endWith:(NSString *)suffix {
    NSRange	range	= [self rangeOfString:suffix];
    return (NSNotFound != range.location && (range.location + range.length) == [self length]);
}

- (BOOL)contains:(NSString*)string
{
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)containsOnlyLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbers].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (NSString *)stringBetweenString:(NSString *)start andString:(NSString *)end
{
    NSRange startRange = [self rangeOfString:start];
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [self length] - targetRange.location;
        NSRange endRange = [self rangeOfString:end options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            return [self substringWithRange:targetRange];
        }
    }
    return nil;
}


#pragma mark - String Validate

- (BOOL)isEmail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return ([emailTest evaluateWithObject:self] && self.length <= 254);
}

- (BOOL)isNumber
{
    NSString *numberRegex = @"^[0-9]+$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:numberRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSInteger number = [regex numberOfMatchesInString:self
                                              options:NSMatchingAnchored
                                                range:NSMakeRange(0, self.length)];
    return (number == 1);
}

- (BOOL)isMobile
{
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:phoneRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSInteger number = [regex numberOfMatchesInString:self
                                              options:NSMatchingAnchored
                                                range:NSMakeRange(0, self.length)];
    return (number == 1);
}

- (BOOL)isUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:userNameRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSInteger number = [regex numberOfMatchesInString:self
                                              options:NSMatchingAnchored
                                                range:NSMakeRange(0, self.length)];
    return (number == 1);
}

- (BOOL)isFloatNumber
{
    
    NSString *numberRegex = @"^0\\.[0-9]{0,1}$|^[0-9]+$|^[1-9][0-9]*\\.[0-9]{0,1}$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:numberRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSInteger number = [regex numberOfMatchesInString:self
                                              options:NSMatchingAnchored
                                                range:NSMakeRange(0, self.length)];
    return (number == 1);
}


#pragma mark - 日期时间相关

- (BOOL)isFutureDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *convertedDate = [df dateFromString:self];
    NSDate *todayDate = [NSDate date];

    NSInteger secs = [todayDate timeIntervalSinceDate:convertedDate];
    return secs<0 ? YES : NO;
}

- (NSUInteger)toTimestamp
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *convertedDate = [df dateFromString:self];
    return [convertedDate timeIntervalSince1970];
}

- (NSDate *)toDateWithFormat:(NSString *)formatString
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatString];

    //用[NSDate date]可以获取系统当前时间
    NSDate *currentDate = [dateFormatter dateFromString:self];

    return currentDate;
}

- (NSString *)toDateStringWithFormat:(NSString *)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [[df dateFromString:self] dateToStringWithDateFormat:format];
}

+ (NSInteger)dateDiffInSeconds:(NSString *)origDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *convertedDate = [df dateFromString:origDate];
    NSDate *todayDate = [NSDate date];

    return (NSInteger)[convertedDate timeIntervalSinceDate:todayDate];
}


+ (NSString *)randomStringWithLength:(NSUInteger)length noNumbers:(BOOL)noNumbers
{
    NSString *alphaLowerCase = @"abcdefghijklmnopqrstuvwxyz";
    NSString *alphaUpperCase = [alphaLowerCase uppercaseString];
    NSString *numbers = @"0123456789";
    
    NSString *selectedSet = [NSString stringWithFormat:@"%@%@%@", alphaLowerCase, alphaUpperCase, numbers];
    if (noNumbers) {
        selectedSet = [NSString stringWithFormat:@"%@%@", alphaLowerCase, alphaUpperCase];
    }
    
    NSString *randomString = @"";
    
    NSRange range = NSMakeRange(0, 1);
    for (int i=0; i<length; i++)
    {
        range.location = arc4random() % [selectedSet length];
        randomString = [randomString stringByAppendingString:[selectedSet substringWithRange:range]];
    }
    
    return randomString;
}



#pragma mark - HTML entity encoding/decoding
// Method based on code obtained from:
// http://www.thinkmac.co.uk/blog/2005/05/removing-entities-from-html-in-cocoa.html
- (NSString *)decodeHtmlEntities
{
    if ([self rangeOfString:@"&"].location == NSNotFound) {
        return self;
    } else {
        NSMutableString *escaped = [NSMutableString stringWithString:self];
        NSArray *codes = [NSArray arrayWithObjects:
                          @"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;", @"&yen;", @"&brvbar;",
                          @"&sect;", @"&uml;", @"&copy;", @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
                          @"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;", @"&acute;", @"&micro;",
                          @"&para;", @"&middot;", @"&cedil;", @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;",
                          @"&frac12;", @"&frac34;", @"&iquest;", @"&Agrave;", @"&Aacute;", @"&Acirc;",
                          @"&Atilde;", @"&Auml;", @"&Aring;", @"&AElig;", @"&Ccedil;", @"&Egrave;",
                          @"&Eacute;", @"&Ecirc;", @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
                          @"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;", @"&Otilde;", @"&Ouml;",
                          @"&times;", @"&Oslash;", @"&Ugrave;", @"&Uacute;", @"&Ucirc;", @"&Uuml;", @"&Yacute;",
                          @"&THORN;", @"&szlig;", @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
                          @"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;", @"&ecirc;", @"&euml;",
                          @"&igrave;", @"&iacute;", @"&icirc;", @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;",
                          @"&oacute;", @"&ocirc;", @"&otilde;", @"&ouml;", @"&divide;", @"&oslash;", @"&ugrave;",
                          @"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;", @"&yuml;", nil];
        
        NSUInteger i, count = [codes count];
        
        // Html
        for (i = 0; i < count; i++) {
            NSRange range = [self rangeOfString:[codes objectAtIndex:i]];
            if (range.location != NSNotFound) {
                [escaped replaceOccurrencesOfString:[codes objectAtIndex:i]
                                         withString:[NSString stringWithFormat:@"%lu", (unsigned long)160 + i]
                                            options:NSLiteralSearch
                                              range:NSMakeRange(0, [escaped length])];
            }
        }
        
        // The following five are not in the 160+ range
        
        // @"&amp;"
        NSRange range = [self rangeOfString:@"&amp;"];
        if (range.location != NSNotFound) {
            [escaped replaceOccurrencesOfString:@"&amp;"
                                     withString:[NSString stringWithFormat:@"%d", 38]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&lt;"
        range = [self rangeOfString:@"&lt;"];
        if (range.location != NSNotFound) {
            [escaped replaceOccurrencesOfString:@"&lt;"
                                     withString:[NSString stringWithFormat:@"%d", 60]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&gt;"
        range = [self rangeOfString:@"&gt;"];
        if (range.location != NSNotFound) {
            [escaped replaceOccurrencesOfString:@"&gt;"
                                     withString:[NSString stringWithFormat:@"%d", 62]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&apos;"
        range = [self rangeOfString:@"&apos;"];
        if (range.location != NSNotFound) {
            [escaped replaceOccurrencesOfString:@"&apos;"
                                     withString:[NSString stringWithFormat:@"%d", 39]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&quot;"
        range = [self rangeOfString:@"&quot;"];
        if (range.location != NSNotFound) {
            [escaped replaceOccurrencesOfString:@"&quot;"
                                     withString:[NSString stringWithFormat:@"%d", 34]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // Decimal & Hex
        NSRange start, finish, searchRange = NSMakeRange(0, [escaped length]);
        i = 0;
        
        while (i < [escaped length]) {
            start = [escaped rangeOfString:@"&#"
                                   options:NSCaseInsensitiveSearch
                                     range:searchRange];
            
            finish = [escaped rangeOfString:@";"
                                    options:NSCaseInsensitiveSearch
                                      range:searchRange];
            
            if (start.location != NSNotFound && finish.location != NSNotFound &&
                finish.location > start.location) {
                NSRange entityRange = NSMakeRange(start.location, (finish.location - start.location) + 1);
                NSString *entity = [escaped substringWithRange:entityRange];
                NSString *value = [entity substringWithRange:NSMakeRange(2, [entity length] - 2)];
                
                [escaped deleteCharactersInRange:entityRange];
                
                if ([value hasPrefix:@"x"]) {
                    unsigned tempInt = 0;
                    NSScanner *scanner = [NSScanner scannerWithString:[value substringFromIndex:1]];
                    [scanner scanHexInt:&tempInt];
                    [escaped insertString:[NSString stringWithFormat:@"%u", tempInt] atIndex:entityRange.location];
                } else {
                    [escaped insertString:[NSString stringWithFormat:@"%d", [value intValue]] atIndex:entityRange.location];
                } i = start.location;
            } else { i++; }
            searchRange = NSMakeRange(i, [escaped length] - i);
        }
        
        return escaped;    // Note this is autoreleased
    }
}

- (NSString *)encodeHtmlEntities
{
    NSMutableString *encoded = [NSMutableString stringWithString:self];
    
    // @"&amp;"
    NSRange range = [self rangeOfString:@"&"];
    if (range.location != NSNotFound) {
        [encoded replaceOccurrencesOfString:@"&"
                                 withString:@"&amp;"
                                    options:NSLiteralSearch
                                      range:NSMakeRange(0, [encoded length])];
    }
    
    // @"&lt;"
    range = [self rangeOfString:@"<"];
    if (range.location != NSNotFound) {
        [encoded replaceOccurrencesOfString:@"<"
                                 withString:@"&lt;"
                                    options:NSLiteralSearch
                                      range:NSMakeRange(0, [encoded length])];
    }
    
    // @"&gt;"
    range = [self rangeOfString:@">"];
    if (range.location != NSNotFound) {
        [encoded replaceOccurrencesOfString:@">"
                                 withString:@"&gt;"
                                    options:NSLiteralSearch
                                      range:NSMakeRange(0, [encoded length])];
    }
    
    return encoded;
}

#pragma mark - URL encoding/decoding

#pragma mark URL encoding
- (NSString *)stringWithURLQueryEscaped
{
	NSString *result = self;
    
	static CFStringRef leaveAlone = CFSTR(" ");
	static CFStringRef toEscape = CFSTR("\n\r:/=,!$&'()*+;[]@#?%");
    
	CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, leaveAlone,
																	 toEscape, kCFStringEncodingUTF8);
    
	if (escapedString) {
		NSMutableString *mutable = [NSMutableString stringWithString:(__bridge NSString *)escapedString];
		CFRelease(escapedString);
        
		[mutable replaceOccurrencesOfString:@" "
                                 withString:@"+"
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [mutable length])];
		result = mutable;
	}
	return result;
}

#pragma mark URL decoding
- (NSString *)stringWithURLQueryUnescaped
{
	NSString *str = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)getURLQuery:(NSString *)queryName {
    NSURLComponents *components = [NSURLComponents componentsWithString:self];
    NSDictionary *dic = [NSDictionary parseQueryString:components.query];
    return [dic stringForKey:queryName withDefault:@""];
}

- (NSString *)setURLQuery:(NSString *)queryName value:(NSString*)queryValue {
    NSURLComponents *components = [NSURLComponents componentsWithString:self];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary parseQueryString:components.query]];
    [dic setObject:queryValue forKey:queryName];

    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in dic) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[dic[key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
    }
    [components setQueryItems:queryItems];

    return components.URL.absoluteString;
}




#pragma mark - String sizes
- (CGSize)computeSizeWithFont:(UIFont *)font
{
    if (![self isKindOfClass:[NSString class]] || !font) {
        return CGSizeZero;
    }
    
    CGSize size;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IS_IOS7) {
        size = [self sizeWithAttributes:@{ NSFontAttributeName: font }];
    }
#else
    size = [self sizeWithFont:font];
#endif
    return size;
}

- (CGFloat)computeWidthWithFont:(UIFont *) font height:(CGFloat) height
{
    if (![self isKindOfClass:[NSString class]] || !font) {
        return 0.0;
    }

    CGFloat newHeight = 0.f;
    CGFloat width = 0.f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IS_IOS7) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName: font }
                                          context:nil];
        
        newHeight = CGRectGetHeight(frame);
        width = CGRectGetWidth(frame);
    }
#else
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(MAXFLOAT, height)
                       lineBreakMode:NSLineBreakByCharWrapping];
    newHeight = size.hight;
    width = size.width;
#endif
    
    if (height > newHeight) {
        NSInteger row = floor(height / newHeight);
        width = ceil(width / row) + 5.0;
    }
    
    return width;
}

- (CGFloat)computeHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    if (![self isKindOfClass:[NSString class]] || !font) {
        return 0.0;
    }
    
    CGFloat height = 0.f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IS_IOS7) {
        height = CGRectGetHeight([self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{ NSFontAttributeName: font }
                                                    context:nil]);
    }
#else
    height = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)
         lineBreakMode:NSLineBreakByCharWrapping].height;
#endif
    return height;
}

- (NSURL *)stringToURL {
    if (!self) return nil;
    return  [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)stringFromURL:(NSURL *)url {
    if (!url) return nil;
    return [url.absoluteString stringByRemovingPercentEncoding];
}

@end
