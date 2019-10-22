//
//  BLSliderView.h
//  BLSinaNewsSliderViewControllerDemo
//
//  Created by boundlessocean on 2016/12/23.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSliderView : UIView
@property (nonatomic,assign) CGFloat sliderWidth;
/**  */
@property (nonatomic,strong) UIColor *sliderColor;
- (void)startAnimation:(BOOL)toRight;
- (void)startAnimationProgress:(CGFloat)progress toRight:(BOOL)toRight;
@end
