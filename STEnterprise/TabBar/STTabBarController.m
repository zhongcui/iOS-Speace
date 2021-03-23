//
//  STTabBarController.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "STTabBarController.h"
#import "STHomePageController.h"
#import "STDispatchViewController.h"
#import "STUserCenterViewController.h"
#import "UIViewController+KooNavBar.h"
#import "UIColor+KooAdd.h"

@interface STTabBarController ()

@end

@implementation STTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self loadSubControllers];
}

- (void)loadSubControllers
{
    self.tabBar.clipsToBounds = YES;//去掉顶部分割线
    [self setupUI];

}

- (void)setupUI{
    [self addChildViewController:[[STHomePageController alloc]init]  imageNamed:@"toolbar_home" title:@"首页"];
    [self addChildViewController:[[STDispatchViewController alloc] init] imageNamed:@"toolbar_dispatch" title:@"发货"];
    [self addChildViewController:[[STUserCenterViewController alloc] init] imageNamed:@"toolbar_user" title:@"个人中心"];
}
- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName title:(NSString *)title{
    //包裹一个自定义的导航
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:childController];
    childController.tabBarItem.title = title;
    childController.kooNavBarTintColor = [UIColor whiteColor];
    childController.kooNavTitileColor = [UIColor colorWithHexString:@"#303030"];
    childController.kooNavBarAlpha = 0.999999;//透明底设置小于1，隐藏底线
    //设置文字样式
    NSMutableDictionary *textAtts = [NSMutableDictionary dictionary];
    textAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#5C5C5C"];
    
    NSMutableDictionary *selectTextAtts = [NSMutableDictionary dictionary];
    selectTextAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#0A7BCD"];

    [childController.tabBarItem setTitleTextAttributes:textAtts forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAtts forState:UIControlStateSelected];
    
    //设置tabBarItem的图标
    //声明：这张图片按照原来的样子显示出来，不要自动渲染成其他颜色（默认蓝色）
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
    
}


@end
