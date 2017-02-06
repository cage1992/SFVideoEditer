//
//  SFButton.h
//  SanKit
//
//  Created by Shelley Shyan on 14-10-11.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFLabel;
@class SFButton;

typedef void(^ActionBlock)(SFButton *button);


@interface SFButton : UIButton

@property (nonatomic, retain) NSDictionary *dic;
@property (nonatomic, copy) ActionBlock actionBlock;
@property (nonatomic, retain) UIView *badgeDot;
@property (nonatomic, retain) SFLabel *badgeNum;

- (instancetype)init;

/**
 * 添加点击动作 block
 */
- (void)addClickBlock:(ActionBlock)block;

/**
 * 添加点击动作 block.
 * 推荐使用 addClickBlock 方法.
 */
- (void)addTarget:(id)target clickActionBlock:(ActionBlock)block;

/**
 * 红点badge
 */
- (void)setHasBadge:(BOOL)hasBadge;

/**
 * 数字 badge
 */
- (void)setBadgeNumber:(NSInteger)num;

@end
