//
//  SFUtility.m
//  SanFramework
//
//  Created by shelley on 14-1-12.
//  Copyright (c) 2014 Sanfriend Co, Ltd. All rights reserved.
//
//  Extended from EGOCache
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

#import "SFUtility.h"
#include <spawn.h>

@implementation SFUtility

+ (void)printCallStackWithCount:(NSUInteger)count
{
    void* callstack[count];
    NSUInteger i, frames = backtrace(callstack, (unsigned int)count);
    char** strs = backtrace_symbols(callstack, (unsigned int)frames);
    for (i = 0; i < frames; ++i) {
        NSLog(@"%@", @(strs[i]));
    }
    free(strs);
    
}

+ (NSString *)osVersion
{
	return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
}

+ (NSString *)appVersion
{
	return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

+ (NSString *)deviceModel
{
	return [UIDevice currentDevice].model;
}

static const char * __jb_app = NULL;

+ (BOOL)isJailBroken
{
	static const char * __jb_apps[] = {
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};

	__jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i ) {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:@(__jb_apps[i])] ) {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
    
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ) {
		return YES;
	}

    // method 3
    pid_t pid;
    int status;
    const char* args[] = {"ls", NULL};
    posix_spawn(&pid, args[0], NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);//wait untill the process completes (only if you need to do that)
	//if ( 0 == system("ls") ) {
    if ( 0 == status ) {
		return YES;
	}
    
    return NO;
}

+ (NSString *)jailBreaker
{
	if ( __jb_app ) {
		return @(__jb_app);
	} else {
		return @"";
	}
}

@end
