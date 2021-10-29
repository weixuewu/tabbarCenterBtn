//
//  YNCenterMenuPopupView.m
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import "YNCenterMenuPopupView.h"

@interface YNCenterMenuPopupView ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIVisualEffectView *centerView;
@property (nonatomic, strong) UIButton *videoBtn;
@property (nonatomic, strong) UIButton *articleBtn;
@property (nonatomic, strong) UIButton *settledBtn;

@end

@implementation YNCenterMenuPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.centerView.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    float width = (self.centerView.frame.size.width-30) / 3.0;
    float marginTop = (self.centerView.frame.size.height - 50) / 2.0;
    self.videoBtn.frame = CGRectMake(15, marginTop, width, 50);
    self.articleBtn.frame = CGRectMake(15+width, marginTop, width, 50);
    self.settledBtn.frame = CGRectMake(15+2*width, marginTop, width, 50);
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissCenterView)];
        [_maskView addGestureRecognizer:tap];
        _maskView.backgroundColor = UIColor.greenColor;
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (void)dismissCenterView {
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIVisualEffectView *)centerView {
    if (!_centerView) {
        _centerView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _centerView.frame = CGRectMake(15, self.frame.size.height - 70 - 30, self.frame.size.width - 30, 70);
        [self.maskView addSubview:_centerView];
    }
    return _centerView;
}

- (UIButton *)videoBtn {
    if (!_videoBtn) {
        _videoBtn = [self createBtnWithTitle:@"视频" icon:@"" action:@selector(tapVideoButton)];
    }
    return _videoBtn;
}

- (void)tapVideoButton {
    [self dismissCenterView];
    if (self.videoBlock) {
        self.videoBlock();
    }
}


- (UIButton *)articleBtn {
    if (!_articleBtn) {
        _articleBtn = [self createBtnWithTitle:@"文章" icon:@"" action:@selector(tapArticleButton)];
    }
    return _articleBtn;
}

- (void)tapArticleButton {
    [self dismissCenterView];
    if (self.articleBlock) {
        self.articleBlock();
    }
}

- (UIButton *)settledBtn {
    if (!_settledBtn) {
        _settledBtn = [self createBtnWithTitle:@"入驻" icon:@"" action:@selector(tapVideoButton)];
    }
    return _settledBtn;
}

- (void)tapSettledButton {
    [self dismissCenterView];
    if (self.settledBlock) {
        self.settledBlock();
    }
}

- (UIButton *)createBtnWithTitle:(NSString *)title icon:(NSString *)icon action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.centerView.contentView addSubview:btn];
    return btn;
}

@end
