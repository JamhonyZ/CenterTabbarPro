//
//  CJTabBarView.h
//  CenterTabberPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 JamHonyZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTabCenterItem : UIButton


@end

@interface CJTabBarView : UIView

/** tabbar按钮显示信息 */
@property(nonatomic, strong) NSArray<UITabBarItem *> *diy_items;


/** 中间按钮 */
@property (strong , nonatomic) CJTabCenterItem *centerBtn;

@end
