//
//  BLSliderViewController.h
//  BLPageSldierTool
//
//  Created by 付海洋 on 2019/10/17.
//

#import <UIKit/UIKit.h>
#import "BLOptionalVeiw.h"

NS_ASSUME_NONNULL_BEGIN
@class BLPagesViewController;
@protocol BLPagesViewControllerDataSource <NSObject>
/** 标题个数 */
- (NSArray<NSString *> *)bl_titlesArrayInSliderViewController;

/** index对应的子控制器 */
- (UIViewController *)bl_sliderViewController:(BLPagesViewController *)sliderVC
                     subViewControllerAtIndxe:(NSInteger)index;
@optional
/** 选中按钮回调 */
- (void)bl_selectedIndex:(NSInteger)index
              scorllView:(UIScrollView *)scorllView;

/** scorllView 滚动回调 */
- (void)bl_scrollViewDidScroll:(UIScrollView *)scorllView;
@end

@interface BLPagesViewController : UIViewController

/** 数据源 */
@property (nonatomic, weak) id<BLPagesViewControllerDataSource> dataSource;

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

/** scorllView */
@property (nonatomic,strong) UIScrollView *scorllView;
/** item高 */
@property (nonatomic,assign) CGFloat itemHeight;
/** 整个分页导航栏 */
@property (nonatomic, strong, readonly) BLOptionalVeiw *optionalView;
@end

NS_ASSUME_NONNULL_END
