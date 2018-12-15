//
//  CJHitTabBar.m
//  CenterTabberPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 JamHonyZ. All rights reserved.
//

#import "CJHitTabBar.h"

@implementation CJHitTabBar

/** 解决发布按钮超出屏幕部分的响应 **/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (_centerBtn) {
        CGRect rect = self.centerBtn.frame;
        if (CGRectContainsPoint(rect, point))
            return self.centerBtn;
    }
    return [super hitTest:point withEvent:event];
}


@end
