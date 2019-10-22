//
//  BLSliderView.m
//  BLSinaNewsSliderViewControllerDemo
//
//  Created by boundlessocean on 2016/12/23.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "BLSliderView.h"
#import <Masonry/Masonry.h>
@interface BLSliderView()
/**  */
@property (nonatomic,strong) UIView *lineView;

/**  */
@property (nonatomic,strong) UIImageView *imageView;
@end
@implementation BLSliderView
{
    dispatch_source_t _timer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setSliderWidth:(CGFloat)sliderWidth{
    _sliderWidth = sliderWidth;
    
    [self addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.sliderWidth*3);
    }];
}

- (void)startAnimationProgress:(CGFloat)progress
                       toRight:(BOOL)toRight{
    
    
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-self.sliderWidth*2*progress);
    }];
    
    [self layoutIfNeeded];
    
    if (toRight) {
        if (progress > 0.9) {
            [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
            }];
            [self layoutIfNeeded];
        }
    }
}


- (void)startAnimation:(BOOL)toRight{
    if (toRight) {
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-self.sliderWidth*2);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
            }];
            [self layoutIfNeeded];
        }];
    } else {
        
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-self.sliderWidth*2);
        }];
        [self layoutIfNeeded];
        
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}


#pragma mark - - Getter

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = UIView.new;
        [_lineView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _lineView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        NSBundle*myBundle = [NSBundle bundleForClass:self.class];
        NSString *path = [[myBundle resourcePath] stringByAppendingPathComponent:@"model_slider.png"];
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    }
    return _imageView;
}

@end
