//
//  YNTabbar.h
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNTabbar : UITabBar

@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic,   copy) dispatch_block_t tapCenterCompletion;

- (void)resetCenterBtn;

@end

NS_ASSUME_NONNULL_END
