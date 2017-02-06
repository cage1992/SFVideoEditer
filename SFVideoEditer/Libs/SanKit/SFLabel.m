//
//  SFLabel.m
//  SanKit
//
//  Created by Shelley Shyan on 14-11-12.
//  Copyright (c) 2014年 Sanfriend Co., Ltd. All rights reserved.
//

#import "SFLabel.h"

@implementation SFLabel

@synthesize insets;

- (void)drawTextInRect:(CGRect)rect
{
    if (self.iconName + self.iconPadding + self.iconSize + self.iconColor < 1) {
        return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
    }

    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(self.insets.top, self.font.pointSize * 1.2+self.iconPadding, self.insets.bottom, self.insets.right))];

    CGFloat iconSize = self.iconSize > 0 ? self.iconSize : self.font.pointSize;

    UILabel *icon = [[UILabel alloc] initWithFrame:CGRectMake(self.insets.left, 0, iconSize, iconSize)];
    icon.text = [NSString sanicon:(SanIcon)self.iconName];

    if (self.iconColor > 0) {
        icon.textColor = [UIColor colorWithRed:(CGFloat)((self.iconColor & 0xFF000000) >> 24) / 255.0
                                         green:(CGFloat)((self.iconColor & 0x00FF0000) >> 16) / 255.0
                                          blue:(CGFloat)((self.iconColor & 0x0000FF00) >> 8) / 255.0
                                         alpha:(CGFloat)((self.iconColor & 0x000000FF)) / 255.0];
    } else {
        icon.textColor = self.textColor;
    }

    icon.font = [UIFont saniconFontOfSize:iconSize];

    CGRect frame = icon.frame;
    frame.origin.y = (self.frame.size.height - frame.size.height)/2;
    icon.frame = frame;

    [self addSubview:icon];
}

@end
