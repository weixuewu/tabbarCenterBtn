//
//  YNCenterMenuPopupView.h
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCenterMenuPopupView : UIView

@property (nonatomic,   copy) dispatch_block_t videoBlock;
@property (nonatomic,   copy) dispatch_block_t articleBlock;
@property (nonatomic,   copy) dispatch_block_t settledBlock;
@property (nonatomic,   copy) dispatch_block_t dismissBlock;

- (void)dismissCenterView;

//+ (void)showCenterMenuFrame:(CGRect)frame
//                 videoBlock:(dispatch_block_t)videoCompletion
//               articleBlock:(dispatch_block_t)articleCompletion
//               settledBlock:(dispatch_block_t)settledCompletion;

@end

NS_ASSUME_NONNULL_END
