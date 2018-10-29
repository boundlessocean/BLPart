//
//  MBProgressHUD+BL.m
//  test
//
//  Created by boundlessocean on 2017/11/20.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import "MBProgressHUD+BL.h"
#import <objc/runtime.h>
@implementation MBProgressHUD (BL)

static char containerViewKey;

+ (MBProgressHUD *)showMsg:(NSString *)message{
    UIView *containerView = [UIApplication sharedApplication].keyWindow;
    return [self showMsg:message inView:containerView delay:1.5];
}

+ (MBProgressHUD *)showMsg:(NSString *)message
                     delay:(NSTimeInterval)timeInterval{
    UIView *containerView = [UIApplication sharedApplication].keyWindow;
    return [self showMsg:message inView:containerView delay:timeInterval];
}

+ (MBProgressHUD *)showBottomMsg:(NSString *)message
                           delay:(NSTimeInterval)timeInterval{
    UIView *containerView = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showMsg:message inView:containerView delay:timeInterval];
    hud.offset = CGPointMake(0.f, [UIScreen mainScreen].bounds.size.height/2 - 100);
    return hud;
}

+ (MBProgressHUD *)showMsg:(NSString *)message
                    inView:(UIView *)view
                     delay:(NSTimeInterval)timeInterval{
    MBProgressHUD *hud = [self showMsg:message inView:view];
    [hud hideAnimated:YES afterDelay:timeInterval];
    return hud;
}


+ (MBProgressHUD *)showMsg:(NSString *)message
                    inView:(UIView *)view{
    objc_setAssociatedObject(self, &containerViewKey, view, OBJC_ASSOCIATION_RETAIN);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.margin = 10;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}


// 隐藏HUD
+ (void)hide:(BOOL)animated{
    UIView *containerView = objc_getAssociatedObject(self, &containerViewKey);
    if (containerView) {
        MBProgressHUD *hud = [MBProgressHUD HUDForView:containerView];
        [hud hideAnimated:YES];
    }
}
@end
