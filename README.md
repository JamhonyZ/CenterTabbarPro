# CenterTabberPro
模仿咸鱼标签栏，实现凸起部分的交互响应

1.自定义CJTabBarView *diy_tabbar（继承UIView） 实现标签按钮的布局。

2.自定义CJHitTabBar *bgTabBar（继承UITabBar） 绑定中心按钮，实现响应者链传递。

3.在标签控制器里替换系统的tabBar

_bgTabBar = [[CJHitTabBar alloc] initWithFrame:self.tabBar.bounds];
  
[self setValue:_bgTabBar forKeyPath:@"tabBar"];
  
4.添加自定义的diy_tabbar

[_bgTabBar insertSubview:self.diy_tabbar atIndex:self.tabBar.subviews.count];

关键代码思路和代码就是如上四个步骤。更多详情参考demo。
