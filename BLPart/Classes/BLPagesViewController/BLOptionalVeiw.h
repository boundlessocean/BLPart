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



/** slider宽 */
@property (nonatomic,assign) CGFloat sliderWidth;
/** slider颜色 */
@property (nonatomic,strong) UIColor *sliderColor;

/** 中间间距 */
@property (nonatomic,assign) CGFloat centerMargin;
/** 左右间距 */
@property (nonatomic,assign) CGFloat lfMargin;

/** 选中字体 */
@property (nonatomic,strong) UIFont *selectedFontSize;
/** 默认字体 */
@property (nonatomic,strong) UIFont *normalFontSize;

/** 选中颜色 */
@property (nonatomic,strong) UIColor *selectedFontColor;
/** 默认颜色 */
@property (nonatomic,strong) UIColor *normalFontColor;
@end
