//
//  ViewController.m
//  TabbarMidAnimation
//
//  Created by weixuewu on 2021/10/29.
//

#import "ViewController.h"
#import "RootViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RootViewController *root = [[RootViewController alloc] init];
    self.view.window.rootViewController = root;
}


@end
