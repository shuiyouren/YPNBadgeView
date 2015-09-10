//
//  YPNBadgeView.m
//  CustomBadgeViewTest
//
//  Created by syr on 15/8/24.
//  Copyright (c) 2015年 syr. All rights reserved.
//

#import "YPNBadgeView.h"

//#import <QuartzCore/QuartzCore.h>

#if !__has_feature(objc_arc)
#error YPNBadgeView must be compiled with ARC.
#endif

static const CGFloat YPNBadgeViewHeight = 16.0f;
static const CGFloat YPNBadgeViewPointWidth = 8.0f;
static const CGFloat YPNBadgeViewTextSideMargin = 8.0f;

@implementation YPNBadgeView

@synthesize badgeCornerRadius = _badgeCornerRadius;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configure];
    }
    
    return self;
}

- (void)configure {
    self.badgeType = YPNBadgeTypeNumber;
    self.badgeText = @"";
    self.badgeTextFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeBackgroundColor = [UIColor redColor];
    self.badgeAlignment = YPNBadgeAlignmentCenter;
    self.badgeMinWidth = YPNBadgeViewHeight;
    self.badgeMaxWidth = CGFLOAT_MAX;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    switch (self.badgeType) {
        case YPNBadgeTypeNumber:
        {
            if ((self.badgeText.length > 0 && self.badgeText.integerValue > 0) || [self.badgeText isEqualToString:self.specificText]) {
                [self drawNumberInRect:rect];
            }
        }
            break;
        case YPNBadgeTypePoint:
        {
            [self drawPointInRect:rect];
        }
            break;
            
        default:
            break;
    }
}

- (void)drawNumberInRect:(CGRect)rect {
    rect = [self rectDrawArea];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rectToDraw = [self rectDrawArea];
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(self.badgeCornerRadius, self.badgeCornerRadius)];
    
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, borderPath.CGPath);
        
        CGContextSetFillColorWithColor(ctx, self.badgeBackgroundColor.CGColor);
        
        CGContextDrawPath(ctx, kCGPathFill);
    }
    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    {
        CGRect textFrame = rect;
        CGSize textSize = [self sizeOfTextForCurrentSettings];
        
        textFrame.size.height = textSize.height;
        textFrame.origin.y = rectToDraw.origin.y + ceilf((rectToDraw.size.height - textFrame.size.height) / 2.0f);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [self.badgeText drawWithRect:textFrame
                             options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                          attributes:@{NSFontAttributeName: self.badgeTextFont, NSForegroundColorAttributeName: self.badgeTextColor, NSParagraphStyleAttributeName: paragraphStyle}
                             context:nil];
        
    }
    CGContextRestoreGState(ctx);
}

- (void)drawPointInRect:(CGRect)rect {
    rect = [self rectDrawArea];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rectToDraw = [self rectDrawArea];
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(self.badgeCornerRadius, self.badgeCornerRadius)];
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, borderPath.CGPath);
        CGContextSetFillColorWithColor(ctx, self.badgeBackgroundColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFill);
    }
    CGContextRestoreGState(ctx);
}

- (CGRect)rectDrawArea {
    CGRect drawRect = CGRectZero;
    CGFloat width = 0;
    CGFloat height = 0;
    switch (self.badgeType) {
        case YPNBadgeTypeNumber:
        {
            CGFloat textWidth = [self sizeOfTextForCurrentSettings].width;
            width = MAX(_badgeMinWidth, textWidth + YPNBadgeViewTextSideMargin);
            width = MIN(_badgeMaxWidth, width);
            height = YPNBadgeViewHeight;
        }
            break;
        case YPNBadgeTypePoint:
        {
            width = YPNBadgeViewPointWidth;
            height = YPNBadgeViewPointWidth;
        }
            break;
            
        default:
            break;
    }
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    if ((self.badgeAlignment & YPNBadgeAlignmentTop) == YPNBadgeAlignmentTop) {
        offsetY = 0;
    }
    else if ((self.badgeAlignment & YPNBadgeAlignmentBottom) == YPNBadgeAlignmentBottom) {
        offsetY = floor(CGRectGetHeight(self.bounds) - height);
    }
    else {
        offsetY = floor((CGRectGetHeight(self.bounds) - height)/2.0f);
    }
    if ((self.badgeAlignment & YPNBadgeAlignmentLeft) == YPNBadgeAlignmentLeft) {
        offsetX = 0;
    }
    else if ((self.badgeAlignment & YPNBadgeAlignmentRight) == YPNBadgeAlignmentRight) {
        offsetX = floor(CGRectGetWidth(self.bounds) - width);
    }
    else {
        offsetX = floor((CGRectGetWidth(self.bounds) - width)/2.0f);
    }
    drawRect.size.width = floor(width) ;
    drawRect.size.height = floor(height);
    drawRect.origin.x = offsetX;
    drawRect.origin.y = offsetY;
    
    return drawRect;
}

#pragma mark - Private

- (CGSize)sizeOfTextForCurrentSettings {
    return [self.badgeText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, YPNBadgeViewHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.badgeTextFont} context:nil].size;
}


#pragma mark - Getter/Setter

- (void)setBadgeText:(NSString *)badgeText {
    if (_badgeText != badgeText) {
        _badgeText = badgeText;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeType:(YPNBadgeType)badgeType {
    if (_badgeType != badgeType) {
        _badgeType = badgeType;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    if (_badgeTextColor != badgeTextColor) {
        _badgeTextColor = badgeTextColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeCornerRadius:(CGFloat)badgeCornerRadius {
    if (_badgeCornerRadius != badgeCornerRadius) {
        _badgeCornerRadius = badgeCornerRadius;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    if (_badgeTextFont != badgeTextFont) {
        _badgeTextFont = badgeTextFont;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    if (_badgeBackgroundColor != badgeBackgroundColor) {
        _badgeBackgroundColor = badgeBackgroundColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeAlignment:(YPNBadgeAlignment)badgeAlignment {
    if (_badgeAlignment != badgeAlignment) {
        _badgeAlignment = badgeAlignment;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeMinWidth:(CGFloat)badgeMinWidth {
    if (_badgeMinWidth != badgeMinWidth) {
        _badgeMinWidth = badgeMinWidth;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeMaxWidth:(CGFloat)badgeMaxWidth {
    if (_badgeMaxWidth != badgeMaxWidth) {
        _badgeMaxWidth = badgeMaxWidth;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (CGFloat)badgeCornerRadius {
    if (_badgeCornerRadius == 0) {
        _badgeCornerRadius = CGRectGetWidth(self.bounds)/2.0f;
    }
    
    return _badgeCornerRadius;
}

@end
