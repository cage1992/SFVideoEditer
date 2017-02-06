//
//  SFTextField.m
//  SanKit
//
//  Created by Shelley Shyan on 14-11-25.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import "SFTextField.h"
#import "SFMacro.h"

@implementation SFTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
        if (IS_IOS7_OR_LATER) {
            self.tintColor = [UIColor grayColor];
        }
    }
    return self;
}

- (void)setPlaceholderText:(NSString *)txt withColor:(UIColor *)color
{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txt attributes:@{NSForegroundColorAttributeName: color}];
    }
}

- (CGRect) textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.insets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], self.insets);
}

@end
