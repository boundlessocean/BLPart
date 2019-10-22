//
//  BLOptionalVeiw.m
//  BLSinaNewsSliderViewControllerDemo
//
//  Created by boundlessocean on 2016/12/23.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "BLOptionalVeiw.h"
#import "BLTitleItem.h"
#import "BLSliderView.h"
#import "Masonry.h"
//@import Masonry;
@interface BLOptionalVeiw ()
/** 滑动条 */
@property (nonatomic, strong) BLSliderView *sliderView;
/** content */
@property (nonatomic,strong) UIView *contentView;
@end

@implementation BLOptionalVeiw

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentView];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.centerY.mas_equalTo(self);
        }];
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

/** 更新 contentOffset */
- (void)updateContentOffset{
    [self.contentView layoutIfNeeded];
    [self.contentView setNeedsDisplay];
    if (self.contentSize.width > self.bounds.size.width) {
        /** 右滑 */
        if (self.sliderView.center.x > self.center.x ) {
            if (self.sliderView.center.x - self.center.x <= self.contentSize.width - self.bounds.size.width) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.contentOffset = CGPointMake(self.sliderView.center.x - self.center.x, 0);
                }];
            } else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.contentOffset = CGPointMake(self.contentSize.width - self.frame.size.width, 0);
                }];
            }
        /** 左滑 */
        } else if(self.sliderView.center.x < self.center.x &&
                  self.contentOffset.x > 0){
            if (self.contentOffset.x - (self.center.x - self.sliderView.center.x) > 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.contentOffset = CGPointMake(self.contentOffset.x - (self.center.x - self.sliderView.center.x), 0);
                }];
            } else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.contentOffset = CGPointZero;
                }];
            }
        }
    }
}

- (void)updateSliderPosition:(BOOL)toRight
                    progress:(CGFloat)progress
                    leftItem:(BLTitleItem *)leftItem
                   rightItem:(BLTitleItem *)rightItem{
    if (progress > 0) {
        
        CGFloat maxRight = rightItem.frame.origin.x + (rightItem.frame.size.width - self.sliderWidth)/2;
        CGFloat minLeft = leftItem.frame.origin.x + (leftItem.frame.size.width - self.sliderWidth)/2;
        if (toRight) {
            [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(minLeft + (maxRight-minLeft)*progress);
            }];
        } else {
            [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(maxRight - (maxRight-minLeft)*(1-progress));
            }];
        }
        [self layoutIfNeeded];
    }
}

#pragma mark - - set

- (void)setTitleArray:(NSArray<NSString *> *)titleArray{
    _titleArray = titleArray;
    
    [self.contentView addSubview:self.sliderView];
    // 添加所有item
    CGFloat left = _lfMargin,
    width;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        CGFloat titleW = [title sizeWithAttributes:@{NSFontAttributeName : self.selectedFontSize}].width;
        width = titleW < self.sliderWidth ? self.sliderWidth : titleW;
        BLTitleItem *item = BLTitleItem.new;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [item setTitle:titleArray[i] forState:UIControlStateNormal];
        item.titleLabel.font = self.normalFontSize;
        [item setTitleColor:_normalFontColor forState:UIControlStateNormal];
        item.tag = i + 100;
        [self.contentView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(left);
            make.width.mas_equalTo(width);
        }];
        
        if (i == titleArray.count - 1) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-self.lfMargin);
            }];
        }
        left += width + _centerMargin;
    }
    
    [self.contentView layoutIfNeeded];
    
    // 第一个item 更改样式
    BLTitleItem *firstItem = [self viewWithTag:100];
    [firstItem setTitleColor:_selectedFontColor forState:UIControlStateNormal];
    firstItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 10));
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.lfMargin);
    }];
}



- (void)setContentOffSetX:(CGFloat)contentOffSetX{
    BOOL toRight = _contentOffSetX < contentOffSetX;
    _contentOffSetX = contentOffSetX;
    NSInteger index = (NSInteger)contentOffSetX / (NSInteger)[UIScreen mainScreen].bounds.size.width;
    // progress 0(屏幕边缘开始) -  1 （满屏结束）
    CGFloat progress =( _contentOffSetX - index * [UIScreen mainScreen].bounds.size.width )/ [[UIScreen mainScreen]bounds].size.width;
    // 左右选项卡（item）
    BLTitleItem *leftItem = [self viewWithTag:index + 100];
    BLTitleItem *rightItem = [self viewWithTag:index + 101];
    /** item 根据progress改变状态 */
    leftItem.progress = 1 - progress;
    rightItem.progress = progress;
    /** slider 波浪动画 */
    if (progress > 0) {
        [_sliderView startAnimationProgress:progress toRight:toRight];
    }
    /** slider 位置更新 */
    [self updateSliderPosition:toRight
                      progress:progress
                      leftItem:leftItem
                     rightItem:rightItem];
    /** 更新contentOffset */
//    [self updateContentOffset];
}

#pragma mark - - lazy load

- (BLSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = BLSliderView.new;
        _sliderView.sliderWidth = self.sliderWidth;
        _sliderView.sliderColor = _sliderColor;
    }
    return _sliderView;
}

- (UIView *)contentView{
    if (!_contentView ) {
        _contentView = UIView.new;
    }
    return _contentView;
}


#pragma mark - - button event

- (void)itemClicked:(BLTitleItem *)sender{
    NSInteger index = (NSInteger)_contentOffSetX / (NSInteger)[UIScreen mainScreen].bounds.size.width;
    if (sender.tag - 100 == index) return;
    BLTitleItem *currentItem = [self viewWithTag:index + 100];
    
    [sender setTitleColor:_selectedFontColor forState:UIControlStateNormal];
    [currentItem setTitleColor:_normalFontColor forState:UIControlStateNormal];
    
    [_sliderView startAnimation:sender.tag > currentItem.tag];
    
    [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sender.frame.origin.x + (sender.frame.size.width - self.sliderWidth)/2);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        currentItem.transform = CGAffineTransformIdentity;
        [self.contentView layoutIfNeeded];
    }];
    !_titleItemClickedCallBackBlock ? : _titleItemClickedCallBackBlock(sender.tag);
}

@end
