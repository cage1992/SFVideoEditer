//
//  Macro.h
//  SanFramework
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


#define ARC4RANDOM_MAX      0x100000000

#ifndef DEBUG_ON
#define DEBUG_ON			NO
#endif

// 常用缩写
#define SCOLOR_WHITE        [UIColor whiteColor]
#define SCOLOR(C)           [UIColor rgbaColor:C]
#define SFONT(S)            [UIFont systemFontOfSize:S]
#define SFONT_BOLD(S)       [UIFont boldSystemFontOfSize:S]
#define SIMAGE(STR)         [UIImage imageNamed:STR]
#define SVIEW(X,Y,W,H)      [[UIView alloc] initWithFrame:CGRectMake((X), (Y), (W), (H))]
#define SLABEL(X,Y,W,H)     [[UILabel alloc] initWithFrame:CGRectMake((X), (Y), (W), (H))]
#define SBUTTON(X,Y,W,H)    [[UIButton alloc] initWithFrame:CGRectMake((X), (Y), (W), (H))]
#define SIMAGEVIEW(X,Y,W,H) [[UIImageView alloc] initWithFrame:CGRectMake((X), (Y), (W), (H))]
#define SVIEW_FRAME(F)      [[UIView alloc] initWithFrame:F]
#define SLABEL_FRAME(F)     [[UILabel alloc] initWithFrame:F]
#define SBUTTON_FRAME(F)    [[UIButton alloc] initWithFrame:F]
#define SIMAGEVIEW_FRAME(F) [[UIImageView alloc] initWithFrame:F]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)          RGBA(r,g,b,1.0f)

#define SBTN_NORMAL         UIControlStateNormal
#define SBTN_HIGHLIGHTED    UIControlStateHighlighted
#define SBTN_SELECTED       UIControlStateSelected
#define SBTN_TOUCHUP        UIControlEventTouchUpInside

// 字体
#define SFONT_XSMALL 		[UIFont systemFontOfSize:13.f]
#define SFONT_SMALL 		[UIFont systemFontOfSize:14.5f]
#define SFONT_TEXT 			[UIFont systemFontOfSize:16.f]
#define SFONT_BODY 			[UIFont systemFontOfSize:16.f]
#define SFONT_SUBTITLE 		[UIFont systemFontOfSize:17.5f]
#define SFONT_TITLE 		[UIFont systemFontOfSize:19.f]
#define SFONT_NORMAL  		[UIFont systemFontOfSize:19.f]
#define SFONT_SYSTEM	  	[UIFont systemFontOfSize:19.f]
#define SFONT_NAVIGATION 	[UIFont systemFontOfSize:21.f]

#define SD_FONT_SIZE_XXSMALL 		11.5f
#define SD_FONT_SIZE_XSMALL 		13.f
#define SD_FONT_SIZE_SMALL 			14.5f
#define SD_FONT_SIZE_TEXT 			16.f
#define SD_FONT_SIZE_BODY 			16.f
#define SD_FONT_SIZE_SUBTITLE 		17.5f
#define SD_FONT_SIZE_TITLE 			19.f
#define SD_FONT_SIZE_NORMAL  		19.f
#define SD_FONT_SIZE_SYSTEM	  		19.f
#define SD_FONT_SIZE_NAVIGATION 	21.f


#define SD_DECORATION_IMAGE         @"icon-decoration"


#ifndef WeakSelf
#define BlockWeakObject(o)  __typeof(o) __weak
#define WeakSelf            BlockWeakObject(self)
#endif

// 高度设置
#define SD_STATUS_BAR_HALF_HEIGHT 	10.f
#define SD_STATUS_BAR_HEIGHT 		20.f 	// 状态条高度
#define SD_SEARCHBAR_OFFSET_Y		44.f	// 搜索条移动高度
#define SD_BOTTOM_BTN_HEIGHT        44.f


#define SD_TABBAR_HEIGHT            49.f
#define SD_TOP_NAV_HEIGHT 		([UIApplication sharedApplication].statusBarHidden ? 44.f : 64.f)  	// 顶部导航条高度 (含状态条)
#define SD_NAV_ONLY_HEIGHT 		44.f 

#define SD_TOP_PADDING   		([UIApplication sharedApplication].statusBarHidden ? 5.f : (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? 24.f : 4.f))   	// 顶部导航内边距


#define SD_WRAPPER_WIDTH 	([[UIScreen mainScreen] bounds].size.width - 20)	 	 // 留出两边后，屏幕可用宽度
#define SD_WRAPPER_X		10  // 16的一半


#define SD_SCREEN_WIDTH 	[[UIScreen mainScreen] bounds].size.width     		 // 全屏宽度
#define SD_SCREEN_HEIGHT 	(([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? ([[UIScreen mainScreen] bounds].size.height) : ([[UIScreen mainScreen] bounds].size.height - 20))	  		 // 全屏幕高度
#define SD_SCREEN_MIDDLE 	([[UIScreen mainScreen] bounds].size.height / 2)     // 屏幕中心高度
#define SD_SCREEN_CENTER_Y 	([[UIScreen mainScreen] bounds].size.height / 2)     // 屏幕中心y值
#define SD_SCREEN_CENTER_X 	([[UIScreen mainScreen] bounds].size.width / 2)     // 屏幕中心x值

#define SD_TAG_START 		98732

// ------------------------------- Device ------------------------
#define IS_IOS7 			([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Is4Inches ([[UIScreen mainScreen] bounds].size.height == 568)
#define Is3_5Inches ([[UIScreen mainScreen] bounds].size.height == 480.0f)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SYSTEM_LANGUAGE 		[[NSLocale preferredLanguages] objectAtIndex:0]


// ------------------------------ Misc ---------------------------
#define IsConnected() !([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define RANDOM_0_TO_1() ((random() / (GLfloat)0x7fffffff ))

#define F(string, args...) [NSString stringWithFormat:string, args]
#define DUMP_FRAME(v)  		(NSLog(@"offset x: %f, offset y: %f, width: %f, height: %f", v.frame.origin.x, v.frame.origin.y, v.frame.size.width, v.frame.size.height))
#define ALERT(title, msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#define NewAlertWarning(title,msg) OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:title message:msg cancelButtonTitle:@"确定"otherButtonTitles:nil]; alert.iconType = OpinionzAlertIconWarning; [alert show];
#define NewAlertSuccess(title,msg) OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:title message:msg cancelButtonTitle:@"确定"otherButtonTitles:nil]; alert.iconType = OpinionzAlertIconSuccess; [alert show];
#define NewAlertInfo(title,msg) OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:title message:msg cancelButtonTitle:@"确定"otherButtonTitles:nil]; alert.iconType = OpinionzAlertIconInfo; [alert show];

#define ALERT_MSG(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]
#define __METHOD__ NSStringFromSelector(_cmd)

#define LS(str)     NSLocalizedString(str, nil)
