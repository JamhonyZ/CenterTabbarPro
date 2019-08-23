//
//  CJRootViewController.m
//  CenterTabberPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 JamHonyZ. All rights reserved.
//

#import "CJRootViewController.h"
#import "CJHitTabBar.h"
#import "CJTabBarView.h"
#import "ViewController.h"
#import "CJTab_Define.h"
#import "CJBaseNaviController.h"

@interface CJRootViewController ()<UITabBarControllerDelegate>
/** items */
@property (nonatomic,strong) NSMutableArray <UITabBarItem *>*items;
/** 自定义的View 响应按钮回调 **/
@property (nonatomic, strong) CJTabBarView *diy_tabbar;
/** 自定义的tabBar 取代系统 **/
@property (nonatomic, strong) CJHitTabBar *bgTabBar;
/** tag值 0到3 是四个控制器 4 是中心按钮 **/
@property (nonatomic, assign) NSInteger itemTag;

@end

@implementation CJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemTag = 0;
    //赋值控制器
    [self addChildsVc];
    //赋值中心按钮
    [self configCenterItem];
    //设置标签栏
    [self configTabbar];
}

/** 添加控制器 **/
- (void)addChildsVc {
    //首页
    ViewController *vc0 = [[ViewController alloc] init];
    [self setupChildViewControllerWith:vc0
                         withImageName:@"icon_home"
                         highImageName:@"icon_home_current" title:@"首页"];
    
    //视频
    ViewController *vc1 = [[ViewController alloc] init];
    [self setupChildViewControllerWith:vc1
                         withImageName:@"icon_videeo"
                         highImageName:@"icon_videeo_current"
                                 title:@"视频"];
    
    //收藏
    ViewController *vc2 = [[ViewController alloc] init];
    [self setupChildViewControllerWith:vc2
                         withImageName:@"icon_Collection"
                         highImageName:@"icon_Collection_current"
                                 title:@"收藏"];
    
    //我的
    ViewController *vc3 = [[ViewController alloc] init];
    [self setupChildViewControllerWith:vc3
                         withImageName:@"icon_my"
                         highImageName:@"icon_my_current" title:@"我的"];
}

/** 设置中心发布按钮 **/
- (void)configCenterItem {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"发布"
                                                       image:CJImage(@"post_animate_add")
                                               selectedImage:CJImage(@"post_animate_add")];
    item.tag = self.itemTag;
    [self.items addObject:item];
    
}

/** 设置标签栏 **/
- (void)configTabbar {
    
    //kvc替换系统tabBar, 并且添加自定义的标签栏
    if (!_bgTabBar) {
        _bgTabBar = [[CJHitTabBar alloc] initWithFrame:self.tabBar.bounds];
        [self setValue:_bgTabBar forKeyPath:@"tabBar"];
        
        //阴影线条的处理
        CGRect rect = CGRectMake(0, 0, kScreenW, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [RGBA(231, 231, 231,.6) CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [_bgTabBar setBackgroundImage:img];
        [_bgTabBar setShadowImage:img];
        
    }
    
    //绑定中心按钮 转移响应者链的代码由 继承系统tabbar的bgTabBar实现
    [_bgTabBar insertSubview:self.diy_tabbar atIndex:self.tabBar.subviews.count];
    _bgTabBar.centerBtn = self.diy_tabbar.centerBtn;
}

#pragma mark -- 赋值标签
- (void)setupChildViewControllerWith:(UIViewController *)viewcontroller
                       withImageName:(NSString *)imageName
                       highImageName:(NSString *)highImageName
                               title:(NSString *)titleString{
    
    CJBaseNaviController *nav = [[CJBaseNaviController alloc] initWithRootViewController:viewcontroller];
    viewcontroller.navigationItem.title = titleString;
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleString
                                                       image:CJImage(imageName)
                                               selectedImage:CJImage(highImageName)];
    item.tag = self.itemTag;
    [self.items addObject:item];
    self.itemTag ++;
    
    [self addChildViewController:nav];
}





#pragma mark -- LazyLoad
- (CJTabBarView *)diy_tabbar{
    if (!_diy_tabbar) {
        _diy_tabbar = [[CJTabBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kTabBarHeight)];
        [_diy_tabbar setValue:self forKey:@"controller"];
        _diy_tabbar.diy_items = self.items;
    }
    return _diy_tabbar;
}
- (NSMutableArray <UITabBarItem *>*)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}


//针对特殊页面，需要切换横屏 操作（例如视频）
- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}


@end
