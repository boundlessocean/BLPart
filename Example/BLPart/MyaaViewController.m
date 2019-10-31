//
//  MyaaViewController.m
//  BLPart_Example
//
//  Created by 付海洋 on 2019/10/31.
//  Copyright © 2019 fuhaiyang. All rights reserved.
//

#import "MyaaViewController.h"
@import BLPart.BLPagesViewController;
@interface MyaaViewController ()

@end

@implementation MyaaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BLPagesViewController *parentViewController = (BLPagesViewController *)self.parentViewController;
    parentViewController.pageViewControllerSelectedBlock = ^(NSInteger index,
                                                             UIViewController * _Nonnull viewController,
                                                             UIScrollView * _Nonnull scrollView) {
        NSLog(@"%d",index);
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
