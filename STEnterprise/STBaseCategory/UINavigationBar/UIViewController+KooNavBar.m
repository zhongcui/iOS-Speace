//
//  UIViewController+KooNavBar.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UIViewController+KooNavBar.h"
#import <objc/runtime.h>
#import "UINavigationController+KooNavAlpha.h"

static const char *kooNavBarAlphaKey = "kooNavBarAlphaKey";
static const char *kooNavBarTintColorKey = "kooNavBarTintColorKey";
static const char *kooNavTintColorKey = "kooNavTintColorKey";
static const char *kooNavTitileColorKey = "kooNavTitileColorKey";
static const char *kooNavTitleTextAttributesKey = "kooNavTitleTextAttributesKey";
static const char *kooNavBackImageKey = "kooNavBackImageKey";

@implementation UIViewController (KooNavBar)

- (void)setKooNavBarAlpha:(CGFloat)kooNavBarAlpha
{
    objc_setAssociatedObject(self, kooNavBarAlphaKey, @(kooNavBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNavigationBarAlpha:kooNavBarAlpha];
}

- (CGFloat)kooNavBarAlpha
{
    id alpha = objc_getAssociatedObject(self, kooNavBarAlphaKey);
    
    if (alpha == NULL)
    {
        return 1.0;
    }
    else
    {
        return [alpha floatValue];
    }
}

- (void)setKooNavBarTintColor:(UIColor *)kooNavBarTintColor
{
    objc_setAssociatedObject(self, kooNavBarTintColorKey, kooNavBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.navigationBar.barTintColor = kooNavBarTintColor;
}

- (UIColor *)kooNavBarTintColor
{
    UIColor *color = objc_getAssociatedObject(self, kooNavBarTintColorKey);
    return color;
}

- (void)setKooNavTintColor:(UIColor *)kooNavTintColor
{
    objc_setAssociatedObject(self, kooNavTintColorKey, kooNavTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.navigationBar.tintColor = kooNavTintColor;
}

- (UIColor *)kooNavTintColor
{
    UIColor *color = objc_getAssociatedObject(self, kooNavTintColorKey);
    return color;
}

- (void)setKooNavTitileColor:(UIColor *)kooNavTitileColor
{
    objc_setAssociatedObject(self, kooNavTitileColorKey, kooNavTitileColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kooNavTitileColor}];
}


- (UIColor *)kooNavTitileColor
{
    UIColor *color = objc_getAssociatedObject(self, kooNavTitileColorKey);
    return color;
}

- (void)setKooNavTitleTextAttributes:(NSDictionary *)kooNavTitleTextAttributes
{
    objc_setAssociatedObject(self, kooNavTitleTextAttributesKey, kooNavTitleTextAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar setTitleTextAttributes:kooNavTitleTextAttributes];
}

- (UIColor *)kooNavTitleTextAttributes
{
    UIColor *color = objc_getAssociatedObject(self, kooNavTitleTextAttributesKey);
    return color;
}



- (void)setKooNavBackImage:(UIImage *)kooNavBackImage
{
    objc_setAssociatedObject(self, kooNavBackImageKey, kooNavBackImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIImage *image = [kooNavBackImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:image];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
}

- (UIImage *)kooNavBackImage
{
    UIImage *image = objc_getAssociatedObject(self, kooNavBackImageKey);
    return image;
}
@end
