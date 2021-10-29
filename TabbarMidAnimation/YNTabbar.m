//
//  YNTabbar.m
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import "YNTabbar.h"

@implementation YNTabbar

// layoutSubviews遍历子控件寻找UITabBarButton，给UITabBarButton重新设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self centerBtn];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat tabBarButtonW = screenWidth / 3;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 中间按钮 增加索引
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex++;
            }
            // 重新设置frame
            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 49);
            child.frame = frame;
            tabBarButtonIndex++;
        }
    }
}

- (void)tapCenter:(UIButton *)sender{
    if (self.tapCenterCompletion) {
        self.tapCenterCompletion();
    }
    
    // 旋转45度
    CGAffineTransform transform = sender.transform;
    transform = CGAffineTransformRotate(transform, M_PI_4);
    sender.transform = transform;
}

- (void)resetCenterBtn {
    CGAffineTransform transform = self.centerBtn.transform;
    transform = CGAffineTransformRotate(transform, -M_PI_4);
    self.centerBtn.transform = transform;
}

- (UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = 50;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _centerBtn.frame = CGRectMake((screenWidth - width)/2, -17, width, width);
        _centerBtn.layer.cornerRadius = 25.0f;
        _centerBtn.layer.masksToBounds = YES;
        _centerBtn.layer.borderColor = UIColor.redColor.CGColor;
        _centerBtn.layer.borderWidth = 2.0f;
        
        [_centerBtn setImage:[UIImage imageNamed:@"nav_publish"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(tapCenter:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtn];
    }
    return _centerBtn;
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return self.centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
