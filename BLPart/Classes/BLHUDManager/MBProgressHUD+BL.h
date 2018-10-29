//
//  MBProgressHUD+BL.h
//  test
//
//  Created by boundlessocean on 2017/11/20.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
// 使用注意:
// 1.正常情况下你不需要调用包含 InView 的方法，除非你需要在指定的view上显示HUD
// 2.进度条 进度在 >= 1时会自动消失
// 3.如果你需要修改进度条颜色 参考.m中_indicator.lineColor 、_indicator.progressColor 、_indicator.progressRemainingColor
// 4.如果你需要修改文字颜色 请在.m中修改 contentColor
// 5.如果你需要修改HUD背景颜色 请在.m中修改 bezelView
// 6.如果你需要文字或图形 边距大小 请在.m中修改 margin
// ***** 7.调用一下两条API如果未显示成功失败图片 -> 项目 ->Build Phases->Copy Bundle Resoure-> +
// ***** + (MBProgressHUD *)showHUDWithSuccessMessage:(NSString *)message;
// ***** + (MBProgressHUD *)showHUDWithFailMessage:(NSString *)message;


@interface MBProgressHUD (BL)

// 隐藏HUD
+ (void)hide:(BOOL)animated;

// 1.5s 后消失
+ (MBProgressHUD *)showMsg:(NSString *)message;

// 指定时间消失
+ (MBProgressHUD *)showMsg:(NSString *)message
                     delay:(NSTimeInterval)timeInterval;
// 文字显示在界面的底部
+ (MBProgressHUD *)showBottomMsg:(NSString *)message
                           delay:(NSTimeInterval)timeInterval;
// 指定view显示HUD
+ (MBProgressHUD *)showMsg:(NSString *)message
                    inView:(UIView *)view;
+ (MBProgressHUD *)showMsg:(NSString *)Message
                    inView:(UIView *)view
                     delay:(NSTimeInterval)timeInterval;

@end
