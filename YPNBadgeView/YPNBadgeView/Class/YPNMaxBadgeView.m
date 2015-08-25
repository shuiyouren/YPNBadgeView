//
//  YPNMaxBadgeView.m
//  CustomBadgeViewTest
//
//  Created by syr on 15/8/25.
//  Copyright (c) 2015年 syr. All rights reserved.
//

#import "YPNMaxBadgeView.h"

@implementation YPNMaxBadgeView

- (void)setBadgeText:(NSString *)badgeText {
    if ([badgeText integerValue] > 99) {
        badgeText = @"99+";
    }
    [super setBadgeText:badgeText];
}

@end
