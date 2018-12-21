//
//  BLPageControlView.h
//  BLPart
//
//  Created by boundlessocean on 2018/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLPageControlView : UIView

@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic) NSInteger indecationWidth;

@end

NS_ASSUME_NONNULL_END
