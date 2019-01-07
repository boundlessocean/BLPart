//
//  MyViewController.m
//  BLPart
//
//  Created by fuhaiyang on 10/29/2018.
//  Copyright (c) 2018 fuhaiyang. All rights reserved.
//

#import "MyViewController.h"
@import Masonry;
@import BLPart.BLBannerView;
@import BLPart.BLSliderViewController;

@interface MyViewController ()<BLSliderViewControllerDataSource>
/** 滑动选项 */
@property (nonatomic, strong) BLSliderViewController *sliderVC;
@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self addChildViewController:self.sliderVC];
//    [self.view addSubview:self.sliderVC.view];
    
    BLBannerView *banner = BLBannerView.new;
    [self.view addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    
    
    banner.datas = @[@"http://racebmst.jingcaishuo.net//static/upfiles/analyst/5e075ac09d56d53f/20181220_173106146000_901.jpg",@"http://racebmst.jingcaishuo.net//static/upfiles/analyst/5e075ac09d56d53f/20181129_113402912000_531.jpg"];
}

#pragma mark - - Getter
- (BLSliderViewController *)sliderVC{
    if (!_sliderVC) {
        _sliderVC = [BLSliderViewController new];
        _sliderVC.dataSource = self;
    }
    return _sliderVC;
}


#pragma mark - - BLSliderViewControllerDataSource
- (NSArray<NSString *> *)bl_titlesArrayInSliderViewController{
    return @[@"全部",@"1-8",@"9-28",@"29-58"];
}

- (__kindof UIViewController *)bl_sliderViewController:(BLSliderViewController *)sliderVC subViewControllerAtIndxe:(NSInteger)index{
    return UIViewController.new;
}

- (CGFloat)bl_optionalViewStartYInSliderViewController{
    return 64;
}

- (CGFloat)bl_viewOfChildViewControllerHeightInSliderViewController{
    return UIScreen.mainScreen.bounds.size.height - 64 - 40;
}

@end
