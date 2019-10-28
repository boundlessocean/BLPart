//
//  BLSliderViewController.m
//  BLPageSldierTool
//
//  Created by 付海洋 on 2019/10/17.
//

#import "BLPagesViewController.h"
#import "Masonry.h"
@interface BLPagesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) BLOptionalVeiw *optionalView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@end

@implementation BLPagesViewController
{
    /** 缓存VC index */
    NSMutableArray<NSNumber *> *_cacheVCIndex;
    CGFloat _oldOffsetX;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 添加子视图 */
    [self initSubViews];
    /** 处理事件回调 */
    [self dealButtonCallBackBlcok];
}

/** 添加子视图 */
- (void)initSubViews{
    _cacheVCIndex = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.optionalView];
    [self.view addSubview:self.mainScrollView];
    
    [_optionalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(self.itemHeight);
        make.width.mas_equalTo(self.view.frame.size.width);
    }];
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.optionalView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(0);
    }];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self initializeSubViewControllerAtIndex:0];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mainScrollView.contentSize = CGSizeMake(_titleArray.count *self.view.frame.size.width, self.view.frame.size.height - self.itemHeight - 10);
}

/** 处理事件回调 */
- (void)dealButtonCallBackBlcok{
    __weak BLPagesViewController *weakSelf = self;
    _optionalView.titleItemClickedCallBackBlock = ^(NSInteger index){
        weakSelf.mainScrollView.contentOffset = CGPointMake((index - 100) * weakSelf.view.frame.size.width , 0);
        if (weakSelf.dataSource &&
            [weakSelf.dataSource respondsToSelector:@selector(bl_selectedIndex:scorllView:)]) {
            [weakSelf.dataSource bl_selectedIndex:(index-100) scorllView:weakSelf.mainScrollView];
        }
    };
}


- (NSArray *)titleArray{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bl_titlesArrayInSliderViewController)]) {
        _titleArray = [self.dataSource bl_titlesArrayInSliderViewController];
    }
    return _titleArray;
}

#pragma mark - - scrollView
/** 偏移量控制显示状态 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / (scrollView.frame.size.width - 1);
    if (scrollView.contentOffset.x > 0) {
        [self.view endEditing:YES];
    }
    
    self.optionalView.contentOffSetX = scrollView.contentOffset.x;
    if (index == 0) return;
    [self initializeSubViewControllerAtIndex:index];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _oldOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.dataSource &&
        scrollView.contentOffset.x != _oldOffsetX &&
        [self.dataSource respondsToSelector:@selector(bl_selectedIndex:scorllView:)]) {
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        [self.dataSource bl_selectedIndex:index scorllView:scrollView];
    }
}


- (void)initializeSubViewControllerAtIndex:(NSInteger)index{
    
    // 添加子控制器
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bl_sliderViewController:subViewControllerAtIndxe:)]) {
        UIViewController *vc = [self.dataSource bl_sliderViewController:self subViewControllerAtIndxe:index];
        if (![_cacheVCIndex containsObject:[NSNumber numberWithInteger:index]]) {
            [_cacheVCIndex addObject:[NSNumber numberWithInteger:index]];
            vc.view.frame = CGRectMake(index * vc.view.frame.size.width, 0, self.mainScrollView.frame.size.width , self.mainScrollView.frame.size.height);
            [self addChildViewController:vc];
            [self.mainScrollView addSubview:vc.view];
        }
    }
}


#pragma mark - - Getter


- (BLOptionalVeiw *)optionalView{
    if (!_optionalView) {
        _optionalView = BLOptionalVeiw.new;
        _optionalView.sliderColor = self.sliderColor;
        _optionalView.sliderWidth = self.sliderWidth;
        _optionalView.centerMargin = self.centerMargin;
        _optionalView.lfMargin = self.lfMargin;
        _optionalView.selectedFontColor = self.selectedFontColor;
        _optionalView.selectedFontSize = self.selectedFontSize;
        _optionalView.normalFontColor = self.normalFontColor;
        _optionalView.normalFontSize = self.normalFontSize;
        _optionalView.titleArray = self.titleArray;
    }
    return _optionalView;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = UIScrollView.new;
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _scorllView = _mainScrollView;
    }
    return _mainScrollView;
}


- (CGFloat)sliderWidth{
    return _sliderWidth > 0 ? _sliderWidth : 37;
}

- (UIColor *)sliderColor{
    return _sliderColor ? _sliderColor : [UIColor colorWithRed:64.0/255 green:102.0/255 blue:245.0/255 alpha:1];
}

- (CGFloat)centerMargin{
    return _centerMargin > 0 ? _centerMargin : 25;
}

- (CGFloat)lfMargin{
    return _lfMargin > 0 ? _lfMargin : 20;
}

- (UIFont *)selectedFontSize{
    return _selectedFontSize ? _selectedFontSize : [UIFont boldSystemFontOfSize:18];
}

- (UIFont *)normalFontSize{
    return _normalFontSize ? _normalFontSize : [UIFont systemFontOfSize:16];
}

- (UIColor *)selectedFontColor{
    return _selectedFontColor ? _selectedFontColor : [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
}

- (UIColor *)normalFontColor{
    return _normalFontColor ? _normalFontColor : [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1];
}

- (CGFloat)itemHeight{
    return _itemHeight ? _itemHeight : 40 ;
}

@end
