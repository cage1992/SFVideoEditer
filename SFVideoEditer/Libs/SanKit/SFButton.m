//
//  SFButton.m
//  SanKit
//
//  Created by Shelley Shyan on 14-10-11.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import "SFButton.h"
#import "Config.h"

@implementation SFButton

@synthesize dic = _dic;

- (instancetype)init
{
    if (self = [super init]) {
        //
    }

    return self;
}

- (void)addClickBlock:(ActionBlock)block
{
    self.actionBlock = [block copy];
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 与上面方法相同
- (void)addTarget:(id)target clickActionBlock:(ActionBlock)block
{
    self.actionBlock = [block copy];
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callActionBlock:(SFButton *)sender
{
    if (self.actionBlock) {
        self.actionBlock(self);
    }
}

- (void)setHasBadge:(BOOL)hasBadge {
    if (!self.badgeDot) {
        self.badgeDot = [[UIView alloc] initWithRoundFrame:CGRectMake(self.right-8, 2, 6, 6) radius:3.f];
        self.badgeDot.backgroundColor = [UIColor redColor];
        [self addSubview:self.badgeDot];
    }

    self.badgeDot.hidden = !hasBadge;
}

- (void)setBadgeNumber:(NSInteger)num {
    if (!self.badgeNum) {
        self.badgeNum = [[SFLabel alloc] initWithRoundFrame:CGRectMake(self.right-18, 7, 15, 15) radius:8.f];
        self.badgeNum.backgroundColor = [UIColor redColor];
        self.badgeNum.textColor = [UIColor whiteColor];
        self.badgeNum.textAlignment = NSTextAlignmentCenter;
        self.badgeNum.font = [UIFont systemFontOfSize:9.f];
        [self addSubview:self.badgeNum];
    }

    self.badgeNum.text = F(@"%ld", (long)num);
    self.badgeNum.hidden = num < 1;
}

@end
