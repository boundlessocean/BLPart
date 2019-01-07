//
//  BLBannerView.m
//  AFNetworking
//
//  Created by boundlessocean on 2018/12/20.
//

#import "BLBannerView.h"
#import "UIImageView+AFNetworking.h"
#import "BLPageControlView.h"
#import "Masonry.h"
@interface BLBannerView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *banner;
@property (nonatomic ,strong) BLPageControlView *pageControl;
@property (nonatomic, copy) void(^animationBlock)(BOOL isfinish) ;
@property (nonatomic, assign) BOOL isfinish;
@end
@implementation BLBannerView{
    dispatch_source_t _timer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.banner];
        [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        __weak typeof(self) weakself = self;
        self.animationBlock = ^(BOOL isfinish) {
            weakself.isfinish = isfinish;
            [weakself p_update];
        };
    }
    return self;
}

#pragma mark - - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/UIScreen.mainScreen.bounds.size.width;
    if (index != _datas.count) {
        self.pageControl.currentPage = index;
    }
    
    if (index == _datas.count) {
        self.pageControl.currentPage = 0;
    }
    [self p_update];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    dispatch_suspend(_timer);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    dispatch_resume(_timer);
}



- (void)p_update{
    if (_isfinish) {
        if (self.banner.contentOffset.x/UIScreen.mainScreen.bounds.size.width >= self.datas.count) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGPoint offset = self.banner.contentOffset;
                offset.x = 0;
                self.banner.contentOffset = offset;
            });
        }
    }
    
}

#pragma mark - - Setter
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    
    [self layoutIfNeeded];
    
    NSMutableArray *tempArray = [_datas mutableCopy];
    
    [self addSubview:self.pageControl];
    if (_datas.count > 1) {
        [tempArray addObject:_datas.firstObject];
        _pageControl.numberOfPages = _datas.count;
    }
  
    
    CGFloat Screen_Width =  UIScreen.mainScreen.bounds.size.width;
    for (int i = 0; i < tempArray.count; i++) {
        UIImageView *image = UIImageView.new;
        image.userInteractionEnabled = YES;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.banner addSubview:image];
        image.tag = i+200;
        [image setImageWithURL:[NSURL URLWithString:tempArray[i]]];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Screen_Width*i);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(self.banner.mas_height);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        if (i != tempArray.count - 1) [image addGestureRecognizer:tap];
    }
    self.banner.contentSize = CGSizeMake(tempArray.count*Screen_Width, self.banner.bounds.size.height);
    if (_datas.count > 1) {
        [self xm_configTimer];
    }
}

#pragma mark - - Private

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *image = (UIImageView *)tap.view;
    !self.bs_viewAction ? : self.bs_viewAction(@1,@(image.tag - 200),NULL);
}

- (void)xm_configTimer{
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, (5 * NSEC_PER_SEC)), (5 * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.isfinish = NO;
                CGPoint offset = self->_banner.contentOffset;
                offset.x = self->_banner.contentOffset.x + UIScreen.mainScreen.bounds.size.width;
                self->_banner.contentOffset = offset;
                
            } completion:^(BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    !self.animationBlock ? : self.animationBlock(finished);
                });
            }];
            
        });
    });
    dispatch_resume(_timer);
}


#pragma mark - - Getter
- (UIScrollView *)banner{
    if (!_banner) {
        _banner = UIScrollView.new;
        _banner.showsVerticalScrollIndicator = NO;
        _banner.showsHorizontalScrollIndicator = NO;
        _banner.delegate = self;
        _banner.pagingEnabled = YES;
        _banner.bounces = NO;
    }
    return _banner;
}

- (BLPageControlView *)pageControl{
    if (!_pageControl) {
        _pageControl = [BLPageControlView new];
        _pageControl.indecationWidth = 6;
    }
    return _pageControl;
}

@end
