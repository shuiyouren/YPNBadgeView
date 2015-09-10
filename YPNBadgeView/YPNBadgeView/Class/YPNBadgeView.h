//
//  YPNBadgeView.h
//  CustomBadgeViewTest
//
//  Created by syr on 15/8/24.
//  Copyright (c) 2015年 syr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YPNBadgeType) {
    YPNBadgeTypeNumber,
    YPNBadgeTypePoint
};

typedef NS_ENUM(NSUInteger, YPNBadgeAlignment) {
    YPNBadgeAlignmentCenter =   (1 << 0),
    YPNBadgeAlignmentTop    =   (1 << 1),
    YPNBadgeAlignmentBottom =   (1 << 2),
    YPNBadgeAlignmentLeft   =   (1 << 3),
    YPNBadgeAlignmentRight  =   (1 << 4)
};

@interface YPNBadgeView : UIView

@property (nonatomic, copy) NSString *badgeText;
@property (nonatomic, assign) YPNBadgeType badgeType;
@property (nonatomic, assign) YPNBadgeAlignment badgeAlignment;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIFont *badgeTextFont;
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
@property (nonatomic, assign) CGFloat badgeCornerRadius;
@property (nonatomic, assign) CGFloat badgeMinWidth;
@property (nonatomic, assign) CGFloat badgeMaxWidth;

@property (nonatomic, strong) NSString *specificText; //可显示的非数值类型的字符
@property (nonatomic, assign, readonly) CGRect rectDrawArea;

@end
