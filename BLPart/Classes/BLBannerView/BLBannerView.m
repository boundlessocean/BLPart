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
@end
@implementation BLBannerView
{
    dispatch_source_t _timer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.banner];
        [self addSubview:self.pageControl];
        [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
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
        CGPoint offset = self->_banner.contentOffset;
        offset.x = 0;
        self->_banner.contentOffset = offset;
    }
    
}

#pragma mark - - Setter
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    NSMutableArray *tempArray = [_datas mutableCopy];
    if (_datas.count > 1) {
        [tempArray addObject:_datas.firstObject];
        _pageControl.numberOfPages = _datas.count;
    }
  
    [self layoutIfNeeded];
    
    CGFloat Screen_Width =  UIScreen.mainScreen.bounds.size.width;
    for (int i = 0; i < tempArray.count; i++) {
        UIImageView *image = UIImageView.new;
        [self.banner addSubview:image];
        [image setImageWithURL:[NSURL URLWithString:tempArray[i]]];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Screen_Width*i);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(self.banner.mas_height);
        }];
    }
    self.banner.contentSize = CGSizeMake(tempArray.count*Screen_Width, self.banner.bounds.size.height);
    if (_datas.count > 1) {
        [self xm_configTimer];
    }
}

#pragma mark - - Private

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
                CGPoint offset = self->_banner.contentOffset;
                offset.x = self->_banner.contentOffset.x + UIScreen.mainScreen.bounds.size.width;
                self->_banner.contentOffset = offset;
            } completion:^(BOOL finished) {
                if (self->_banner.contentOffset.x/UIScreen.mainScreen.bounds.size.width == self->_datas.count) {
                    CGPoint offset = self->_banner.contentOffset;
                    offset.x = 0;
                    self->_banner.contentOffset = offset;
                }
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
        _pageControl.indecationWidth = 12;
    }
    return _pageControl;
}

@end
