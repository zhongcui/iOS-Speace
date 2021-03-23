//
//  UINavigationController+KooUpStatusBar.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UINavigationController+KooUpStatusBar.h"

@implementation UINavigationController (KooUpStatusBar)

-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
@end
