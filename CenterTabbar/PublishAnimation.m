//
//  PublishAnimation.m
//  LaughPro
//
//  Created by zzh on 2018/12/14.
//  Copyright © 2018年 YR. All rights reserved.
//

#import "PublishAnimation.h"
#import "CJTab_Define.h"

#define bl [[UIScreen mainScreen]bounds].size.width/375

@interface PublishAnimation()

@property (strong , nonatomic) UIButton *centerBtn;
@property (strong , nonatomic) NSMutableArray *btnItem;
@property (strong , nonatomic) NSMutableArray *btnItemTitle;
@property (nonatomic,assign) CGRect rect;

@end

@implementation PublishAnimation


/**
 *  直接展示
 */
+(PublishAnimation *)standardMiddleAnimationWithView:(UIView *)view {
    
    PublishAnimation * animateView = [[PublishAnimation alloc] init];
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:animateView];
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:view.frame fromView:view.superview];
    rect.origin.y -= kSafeArea_Bottom;
    animateView.rect = rect;
    

    [animateView CrentBtnImageName:@"post_animate_add" Title:@"发布视频" tag:0];
    [animateView CrentBtnImageName:@"post_animate_add" Title:@"发布动态" tag:1];
    [animateView CrentBtnImageName:@"post_animate_add" Title:@"一键转卖" tag:2];
    
    [animateView CrentCenterBtnImageName:@"post_animate_add" tag:2];

    [animateView AnimateBegin];
    
    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
    }
    return self;
}


/** 创建按钮 **/
- (void)CrentBtnImageName:(NSString *)ImageName Title:(NSString *)Title tag:(int)tag{
    if (_btnItem.count >= 3)  return;
    UIButton * btn = [[UIButton alloc] initWithFrame:self.rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.btnItem addObject:btn];
    UILabel *lbl = [self CrenterBtnTitle:Title];
    [self.btnItemTitle addObject:lbl];
}


/** 创建中心按钮 **/
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _centerBtn = [[UIButton alloc] initWithFrame:self.rect];
    [_centerBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_centerBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _centerBtn.tag = tag;
    [self addSubview:_centerBtn];
}


- (UILabel *)CrenterBtnTitle:(NSString *)Title{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = Title;
    [self addSubview:lab];
    return lab;
}


- (void)removeView:(UIButton*)btn{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}


- (void)clickAction:(UIButton*)btn{
    NSLog(@"点击:%@",self.btnItemTitle[btn.tag]);
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
    [self removeFromSuperview];
}



- (void)AnimateBegin{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.centerBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.centerBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.centerBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    
    
    __block int  i = 0 , k = 0;
    for (UIView *  btn in _btnItem) {
        //rotation
        [UIView animateWithDuration:0.7 delay:i*0.14 usingSpringWithDamping:0.46 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.2734*bl, 1.2734*bl);//缩放
            btn.center = CGPointMake((74+i++*113)*bl, self.frame.size.height-200*bl-kSafeArea_Bottom);
            
        } completion:nil];
        
        //move
        [UIView animateWithDuration:0.2
                              delay:i*0.1
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
            btn.transform = CGAffineTransformRotate (btn.transform, -M_2_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                btn.transform = CGAffineTransformRotate (btn.transform, M_2_PI+M_LOG10E);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1
                                      delay:0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                    btn.transform = CGAffineTransformRotate (btn.transform, -M_LOG10E);
                } completion:^(BOOL finished) {
                    UILabel * lab = (UILabel *)self.btnItemTitle[k++];
                    lab.frame = CGRectMake(0, 0, kScreenW/3-30, 30);
                    lab.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+20);
                }];
            }];
        }];
    }
    
    
}



- (void)cancelAnimation{
    
    [UIView animateWithDuration:0.15 animations:^{
        self.centerBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        
        int n = (int)self.btnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = self.btnItem[i];
            [UIButton animateWithDuration:0.25
                                    delay:0.1*(n-i)
                                  options:UIViewAnimationOptionTransitionCurlDown
                               animations:^{
                                   
                btn.center = CGPointMake(kScreenW/2 ,kScreenH-40-kSafeArea_Bottom);
                btn.transform = CGAffineTransformMakeScale(.8, .8);
                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)self.btnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [self removeFromSuperview];
                }
            }];
        }
    }];
    
}


#pragma mark -- LazyLoad
- (NSMutableArray *)btnItem{
    if (!_btnItem) {
        _btnItem = [NSMutableArray array];
    }
    return _btnItem;
}
- (NSMutableArray *)btnItemTitle{
    if (!_btnItemTitle) {
        _btnItemTitle = [NSMutableArray array];
    }
    return _btnItemTitle;
}

#pragma mark -- 机型判断
+ (BOOL)checkIsIphoneX {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

@end
