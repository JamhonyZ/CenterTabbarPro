//
//  PublishAnimation.h
//  LaughPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 YR. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol PublishAnimationDelegate <NSObject>

- (void)didSelectBtnWithBtnTag:(NSInteger)tag;

@end

@interface PublishAnimation : UIView

@property(nonatomic,weak) id<PublishAnimationDelegate> delegate;

/** 类方法调用 */
+(PublishAnimation *)standardMiddleAnimationWithView:(UIView *)view;

+ (BOOL)checkIsIphoneX;

@end
