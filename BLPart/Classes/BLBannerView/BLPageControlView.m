//
//  BLPageControlView.m
//  BLPart
//
//  Created by boundlessocean on 2018/12/20.
//

#import "BLPageControlView.h"

static const CGFloat itemH = 12;
static const CGFloat margin = 4;
@implementation BLPageControlView

- (instancetype)init{
    self = [super init];
    if (self) {
        _indecationWidth = 6;
    }
    return self;
}


- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    if (_numberOfPages == 1) return;
    CGFloat width = (_indecationWidth + margin * 2) * numberOfPages;
    self.frame = CGRectMake((self.superview.bounds.size.width - width)/2, self.superview.bounds.size.height - 22, width, itemH);
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *view = [UIView new];
        [self addSubview:view];
        CGFloat x = margin + i*(_indecationWidth + margin * 2);
        view.layer.cornerRadius = 3;
        view.frame = CGRectMake(x, (itemH - _indecationWidth)/2, _indecationWidth, 6);
        view.tag = 100+i;
    }
    self.currentPage = 0;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    UIView *current = [self viewWithTag:100+_currentPage];
    current.backgroundColor = UIColor.yellowColor;
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *view = [self viewWithTag:i+100];
        if (current == view) continue;
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderWidth = 1;
        view.layer.borderColor = UIColor.whiteColor.CGColor;
    }
}

@end
