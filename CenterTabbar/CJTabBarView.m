//
//  CJTabBarView.m
//  CenterTabberPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 JamHonyZ. All rights reserved.
//

#import "CJTabBarView.h"
#import "CJTab_Define.h"
#import "UIButton+cjBtn.h"
#import "PublishAnimation.h"

#define kFont10 [UIFont systemFontOfSize:10]

@implementation CJTabCenterItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = kFont10;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:UIColorHex(0xAAAAAA) forState:0];
        self.titleLabel.textAlignment = 1;
    }
    return self;
}
@end


@interface CJTabBarView()

/** 除中间按钮之外的item **/
@property (nonatomic, strong) NSMutableArray <UIButton *>*btnArr;
/** tabBarController */
@property (weak , nonatomic) UITabBarController *controller;
/** 上一个选中的按钮 **/
@property (nonatomic, strong) UIButton *lastSelcetBtn;
/** 圆弧 **/
@property (nonatomic, strong) UIBezierPath *path;


@end

@implementation CJTabBarView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.btnArr = @[].mutableCopy;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowColor = self.backgroundColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -0.5);
        
        /*
        //自定义tabbar属性
        [UITabBar appearance].shadowImage = [[UIImage alloc] init];
        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [UITabBar appearance].translucent = NO;
        //未选中状态的标题颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:UIColorHex(0xAAAAAA)} forState:UIControlStateNormal];
        //选中状态的标题颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:UIColorHex(0xE73C45)} forState:UIControlStateSelected];
         */
    }
    return self;
}

- (void)setDiy_items:(NSArray<UITabBarItem *> *)diy_items{
    _diy_items = diy_items;
    for (int i=0; i<_diy_items.count; i++)
    {
        UITabBarItem *item = _diy_items[i];
        UIButton *btn = nil;
        if (i == _diy_items.count-1)
        {
            self.centerBtn = [CJTabCenterItem buttonWithType:UIButtonTypeCustom];
            self.centerBtn.adjustsImageWhenHighlighted = NO;
            btn = self.centerBtn;
            [btn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.btnArr addObject:btn];
            [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        btn.titleLabel.textAlignment = 1;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorHex(0xAAAAAA) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorHex(0xE73C45) forState:UIControlStateSelected];
        
        btn.tag = item.tag;
        [self addSubview:btn];
    }
    
    
    //设置默认第一个为选中
    [self itemClick:self.btnArr.firstObject];
}

#pragma mark -- Action
- (void)centerBtnClick:(UIButton *)btn {
    
    [PublishAnimation standardMiddleAnimationWithView:btn];
}

- (void)itemClick:(UIButton *)button {
    
    if (_lastSelcetBtn.tag == button.tag && _lastSelcetBtn) {
        NSLog(@"重复点击第%@个tabitem", @(button.tag));
        return;
    }
    _lastSelcetBtn.selected = NO;
    self.controller.selectedIndex = button.tag;
    button.selected = YES;
    _lastSelcetBtn = button;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat item_width = kScreenW/self.diy_items.count;
    
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat left = idx < 2 ? item_width*idx : item_width*(idx+1);
        obj.frame = CGRectMake(left, 0, item_width, CGRectGetHeight(self.frame));
        obj.imageRect = CGRectMake((item_width-24)/2, 5, 24, 24);
        obj.titleRect = CGRectMake(0, CGRectGetHeight(obj.frame)-15, item_width, 11);
        obj.titleLabel.font = kFont10;
    }];
    
    CGFloat imageW = 60;
    self.centerBtn.frame = CGRectMake((kScreenW-item_width)/2, -imageW/2, item_width, CGRectGetHeight(self.frame)+imageW/2);
    
    self.centerBtn.imageRect = CGRectMake((item_width-imageW)/2, 0, imageW, imageW);
    self.centerBtn.titleRect = CGRectMake(0, CGRectGetHeight(self.centerBtn.frame)-15, CGRectGetWidth(self.centerBtn.frame), 11);
    
    if (!_path) {
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.lineWidth = .5;
        layer.strokeColor = RGB(231, 231, 231).CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.shadowOpacity = 0.2;
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(0, -0.5);
        BOOL clockWise = true;
        _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, 0) radius:imageW/2-1 startAngle:(1.0 * M_PI) endAngle:2.0 * M_PI clockwise:clockWise];
        layer.path = [_path CGPath];
        [self.layer addSublayer:layer];
    }
}



@end
