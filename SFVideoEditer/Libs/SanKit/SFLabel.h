//
//  SFLabel.h
//  SanKit
//
//  Created by Shelley Shyan on 14-11-12.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SanIcon.h"

@interface SFLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets insets;

// SanIcon settings
@property (nonatomic, assign) SanIcon iconName;
@property (nonatomic, assign) CGFloat iconPadding;
@property (nonatomic, assign) CGFloat iconSize;
@property (nonatomic, assign) NSInteger iconColor; // hex color: 0xrrggbbaa

@end
