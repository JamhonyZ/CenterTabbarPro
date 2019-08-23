//
//  CJTab_Define.h
//  CenterTabberPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 JamHonyZ. All rights reserved.
//

#ifndef CJTab_Define_h
#define CJTab_Define_h

#import "PublishAnimation.h"
//RGB色
#define RGBA(r,g,b,a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)            RGBA(r,g,b,1.0f)

// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kRandomColor [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];


//主窗口&&主宽高
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define  ISIPHONEX [PublishAnimation checkIsIphoneX]
#define  kStatusBarHeight  (ISIPHONEX ? 44.f : 20.f)
#define  kStatusBarAndNavigationBarHeight  (ISIPHONEX ? 88.f : 64.f)
#define  kNaviBarHeight 44
#define  kTabBarHeight  (ISIPHONEX ? 83.f : 49.f)
#define  kSafeArea_Bottom    (ISIPHONEX ? 34.f : 0.f)



#define CJImage(imageName) [UIImage imageNamed:imageName]

#endif /* CJTab_Define_h */
