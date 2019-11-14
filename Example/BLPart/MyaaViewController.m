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
    CGFloat hue = (arc4random() %256/256.0);
    
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    self.view.backgroundColor = color;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
