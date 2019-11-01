//
//  BLTitleItem.m
//  BLSinaNewsSliderViewControllerDemo
//
//  Created by boundlessocean on 2016/12/23.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "BLTitleItem.h"

@implementation BLTitleItem

// 滑动进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (_progress > 0 && _progress <= 1) {
        CGFloat cv = 187.0 - 136.0*_progress;
        [self setTitleColor:[UIColor colorWithRed:cv/255.0 green:cv/255.0 blue:cv/255.0 alpha:1] forState:UIControlStateNormal];
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + 0.1 * _progress, 1 + 0.1 * _progress);
    }
}
@end
