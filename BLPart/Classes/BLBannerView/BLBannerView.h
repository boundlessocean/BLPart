//
//  BLBannerView.h
//  AFNetworking
//
//  Created by boundlessocean on 2018/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLBannerView : UIView
@property(nonatomic,copy) void(^bs_viewAction)(id data,...);
@property (nonatomic ,strong) NSArray *datas;
@end

NS_ASSUME_NONNULL_END
