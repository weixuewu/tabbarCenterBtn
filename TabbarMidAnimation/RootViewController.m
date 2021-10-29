//
//  RootViewController.m
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import "RootViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "YNTabbar.h"
#import "YNCenterMenuPopupView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface RootViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) YNTabbar *ynTabbar;
@property (nonatomic, strong) YNCenterMenuPopupView *popupView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /********************设置tabbar*******************/
    self.ynTabbar = [[YNTabbar alloc]init];
    [self setValue:self.ynTabbar forKey:@"tabBar"];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.barTintColor = UIColor.whiteColor;
    [UITabBar appearance].translucent = NO;
    UITabBar.appearance.backgroundColor = UIColor.orangeColor;
    
    __weak typeof(self) weakself = self;
    self.ynTabbar.tapCenterCompletion = ^{
        [weakself tapCenter];
    };
    
    //首页
    AViewController *homeVC = [[AViewController alloc]init];
    [self addChildVC:homeVC title:@"首页"];
    
    //商城
    BViewController *shoppingVC = [[BViewController alloc]init];
    [self addChildVC:shoppingVC title:@"商城"];
    
    
    self.selectedIndex = 0;
    self.delegate = self;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
        
    [self.popupView dismissCenterView];
    self.popupView = nil;

}

- (void)setTabbarItemtextColorWithIndex:(NSInteger)index{
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:(index ? UIColor.blackColor : UIColor.whiteColor),NSFontAttributeName:[UIFont systemFontOfSize:14]};
            NSDictionary *textTitleOptionsSelected = @{NSForegroundColorAttributeName:(index ? UIColor.greenColor: UIColor.whiteColor), NSFontAttributeName:[UIFont systemFontOfSize:16]};
            [nav.tabBarItem setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
            [nav.tabBarItem setTitleTextAttributes:textTitleOptionsSelected forState:UIControlStateSelected];
        }
    }
}


- (void)addChildVC:(UIViewController *)viewcontroller title:(NSString *)title{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
    NSDictionary *titleOptions = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:UIColor.whiteColor};
    NSDictionary *titleOptionsSelected = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:UIColor.redColor};
    [nav.tabBarItem setTitleTextAttributes:titleOptions forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:titleOptionsSelected forState:UIControlStateSelected];
    nav.tabBarItem.title = title;
    [self addChildViewController:nav];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -15)];
}


- (void)tapCenter {
    CGSize size = [UIScreen mainScreen].bounds.size;
    YNCenterMenuPopupView *popup = [[YNCenterMenuPopupView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - self.tabBar.frame.size.height)];
    popup.dismissBlock = ^{
        [self.ynTabbar resetCenterBtn];
    };
    popup.videoBlock = ^{

    };
    popup.articleBlock = ^{

    };
    popup.settledBlock = ^{

    };
    [self.view insertSubview:popup atIndex:1];
    self.popupView = popup;
}

- (UIImage *)imageWithColor:(UIColor *)color{
    
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    [color set];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
