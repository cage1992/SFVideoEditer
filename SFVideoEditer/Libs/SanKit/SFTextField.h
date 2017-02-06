//
//  SFTextField.h
//  SanKit
//
//  Created by Shelley Shyan on 14-11-25.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFTextField : UITextField

@property (assign, nonatomic) UIEdgeInsets insets;

/**
 * 设置placeholder文本和颜色
 */
- (void)setPlaceholderText:(NSString *)txt withColor:(UIColor *)color;

@end
