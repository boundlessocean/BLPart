//
//  BLOptionalVeiw.h
//  BLSinaNewsSliderViewControllerDemo
//
//  Created by boundlessocean on 2016/12/23.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLOptionalVeiw : UIScrollView
/** 标题数组 */
@property (nonatomic, strong) NSArray <NSString *> *titleArray;
/** item点击回调 */
@property (nonatomic, copy) void (^titleItemClickedCallBackBlock)(NSInteger index);
/** 偏移量 */
@property (nonatomic, assign) CGFloat contentOffSetX;
/** 标题偏移量 */
@property (nonatomic, assign) CGFloat titleOffset;
/** 分割线颜色 */
@property (nonatomic, strong) UIColor *lineColor;
@end
