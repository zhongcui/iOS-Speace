//
//  UINavigationController+KooAlpha.m
//  TestNav//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UINavigationController+KooNavAlpha.h"
#import <objc/runtime.h>
#import "UIViewController+KooNavBar.h"

@implementation UINavigationController (KooNavAlpha)
/// 设置导航栏透明度
- (void)setNavigationBarAlpha:(CGFloat)alpha
{
  if (self.navigationBar.subviews.count)
     {
         UIView *barBgView = self.navigationBar.subviews[0];
         UIView * shadowView;
         if (@available(iOS 13.0, *)){
              /** iOS13不让拿私有属性了 */
             if (barBgView.subviews.count) {
                 shadowView = barBgView.subviews[0];
             }
         }else{
             shadowView = [barBgView valueForKey:@"_shadowView"];
         }
         
       
         if (shadowView)
         {
             if (alpha < 1)
             {
                 shadowView.hidden = YES;
             }
             else
             {
                 shadowView.hidden = NO;
                 shadowView.alpha  = alpha;
             }
         }
         if (self.navigationBar.isTranslucent)
         {
             if (@available(iOS 13.0, *)) {
                 /** iOS13不让拿私有属性了 */
                 UIView *bgEffectView;
                 if (barBgView.subviews.count > 1) {
                     bgEffectView = barBgView.subviews[1];
                 }
                 if (bgEffectView && [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] == nil) {
                     bgEffectView.alpha = alpha;
                 }
                 
             } else if (@available(iOS 10.0, *)) {
                 UIView *bgEffectView = [barBgView valueForKey:@"_backgroundEffectView"];
                 
                 if (bgEffectView && [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] == nil) {
                     bgEffectView.alpha = alpha;
                 }
             } else {
                 UIView *adaptiveBackDrop = [barBgView valueForKey:@"_adaptiveBackdrop"];
                 UIView *backDropEffectView = [adaptiveBackDrop valueForKey:@"_backdropEffectView"];
                 if (adaptiveBackDrop && backDropEffectView) {
                     backDropEffectView.alpha = alpha;
                 }
             }
         }
         barBgView.alpha = alpha; // 解决手势返回时，透明Bar页面与不透明bar页面切换会闪烁的问题.
     }
}

+ (void)swizzleOriginalSelector:(SEL)originalSelector withCurrentSelector:(SEL)currentSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, currentSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            currentSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (self == [UINavigationController class])
        {
            SEL originalSelector1  = NSSelectorFromString(@"_updateInteractiveTransition:");
            SEL swizzledSelector1  = NSSelectorFromString(@"z_updateInteractiveTransition:");
            [self swizzleOriginalSelector:originalSelector1 withCurrentSelector:swizzledSelector1];
            
            SEL originalSelector2  = @selector(popToRootViewControllerAnimated:);
            SEL swizzledSelector2  = NSSelectorFromString(@"z_popToRootViewControllerAnimated:");
            [self swizzleOriginalSelector:originalSelector2 withCurrentSelector:swizzledSelector2];
            
            SEL originalSelector6  = @selector(popToViewController:animated:);
            SEL swizzledSelector6  = NSSelectorFromString(@"z_popToViewController:animated:");
            [self swizzleOriginalSelector:originalSelector6 withCurrentSelector:swizzledSelector6];
            
            SEL originalSelector3  = @selector(initWithCoder:);
            SEL swizzledSelector3  = NSSelectorFromString(@"z_initWithCoder:");
            [self swizzleOriginalSelector:originalSelector3 withCurrentSelector:swizzledSelector3];
            
            SEL originalSelector4  = @selector(initWithRootViewController:);
            SEL swizzledSelector4  = NSSelectorFromString(@"z_initWithRootViewController:");
            [self swizzleOriginalSelector:originalSelector4 withCurrentSelector:swizzledSelector4];
            
            SEL originalSelector7  = @selector(popViewControllerAnimated:);
            SEL swizzledSelector7  = NSSelectorFromString(@"z_popViewControllerAnimated:");
            [self swizzleOriginalSelector:originalSelector7 withCurrentSelector:swizzledSelector7];
        }
    });
}

- (instancetype)z_initWithCoder:(NSCoder *)aDecoder
{
    UINavigationController *nav = [self z_initWithCoder:aDecoder];
    nav.delegate = nav;
    return nav;
}

- (instancetype)z_initWithRootViewController:(UIViewController *)rootViewController
{
    UINavigationController *nav = [self z_initWithRootViewController:rootViewController];
    nav.delegate = nav;
    return nav;
}

- (void)z_updateInteractiveTransition:(CGFloat)percentComplete
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator)
    {
        id<UIViewControllerTransitionCoordinator> coor = self.topViewController.transitionCoordinator;
        
        UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC   = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
        
        // alpha
        CGFloat fromAlpha = fromVC.kooNavBarAlpha;
        CGFloat toAlpha = toVC.kooNavBarAlpha;
        CGFloat alpha = fromAlpha + (toAlpha - fromAlpha)*percentComplete;
        [self setNavigationBarAlpha:alpha];
        
        // bartint color
        if(fromVC.kooNavBarTintColor != nil && toVC.kooNavBarTintColor != nil)
        {
            UIColor *newColor = [self getColorWithFromColor:fromVC.kooNavBarTintColor toColor:toVC.kooNavBarTintColor percentComplete:percentComplete];
            self.navigationBar.barTintColor = newColor;
        }
    }
    
    [self z_updateInteractiveTransition:percentComplete];
}

- (NSArray<__kindof UIViewController *> *)z_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray<UIViewController *> *poppedViewControllers = [self z_popToViewController:viewController animated:animated];
    [self updateBarAppearenceWithViewController:self.topViewController];
    return poppedViewControllers;
}

- (nullable UIViewController *)z_popViewControllerAnimated:(BOOL)animated
{
    UIViewController *poppedController = [self z_popViewControllerAnimated:animated];
    [self updateBarAppearenceWithViewController:self.topViewController];
    return poppedController;
}

- (NSArray<UIViewController *> *)z_popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray<UIViewController *> *poppedViewControllers = [self z_popToRootViewControllerAnimated:animated];
    [self updateBarAppearenceWithViewController:self.topViewController];
    return poppedViewControllers;
}

#pragma mark- UINavigationBarDelegate
// 点击返回
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    BOOL interactive = [self.topViewController.transitionCoordinator initiallyInteractive];
    if (interactive)         // 交互式pop
    {
        if (@available(iOS 10.0, *))
        {
            [self.topViewController.transitionCoordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        else
        {
            [self.topViewController.transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    
    if (@available(iOS 13.0, *)) { //13系统不用加加了会崩溃
        
    }else{
        // 非交互式pop
        NSUInteger itemCount = self.navigationBar.items.count;
        if (itemCount >= 2)
        {
            UIViewController *popToVC = self.viewControllers[itemCount - 2];
            [self popToViewController:popToVC animated:YES];
        }
    }
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    [self updateBarAppearenceWithViewController:self.topViewController];
    return YES;
}

#pragma mark- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self updateBarAppearenceWithViewController:viewController];

    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    if (viewController.kooNavBackImage == nil && navigationController.viewControllers.firstObject != viewController)
    {
        UIImage *loadImage = [UIImage imageNamed:@"nav_back_dark"];
        UIImage *image = [loadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationBar setBackIndicatorImage:image];
        [self.navigationBar setBackIndicatorTransitionMaskImage:image];
    }
    
    BOOL interactive = [self.topViewController.transitionCoordinator initiallyInteractive];
    if (interactive)         // 交互式pop
    {
        if (@available(iOS 10.0, *))
        {
            [self.topViewController.transitionCoordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        else
        {
            [self.topViewController.transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController
    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
{
        if (self.viewControllers.count > 1)
        {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
#pragma mark- Methods
- (void)updateBarAppearenceWithViewController:(UIViewController *)viewController
{
    if (viewController.kooNavBackImage != nil &&  viewController.kooNavBackImage != NULL)
    {
        UIImage *image = [viewController.kooNavBackImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationBar setBackIndicatorImage:image];
        [self.navigationBar setBackIndicatorTransitionMaskImage:image];
    }
    
//    if (viewController.kooNavBarTintColor != nil &&  viewController.kooNavBarTintColor != NULL)
    {
        [self.navigationBar setBarTintColor:viewController.kooNavBarTintColor];
    }
    
    if (viewController.kooNavTintColor != nil &&  viewController.kooNavTintColor != NULL)
    {
        [self.navigationBar setTintColor:viewController.kooNavTintColor];
    }
    
    if (viewController.kooNavTitileColor != nil &&  viewController.kooNavTitileColor != NULL)
    {
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:viewController.kooNavTitileColor}];
    }
    
    if (viewController.kooNavTitleTextAttributes != nil &&  viewController.kooNavTitleTextAttributes != NULL)
    {
        [self.navigationBar setTitleTextAttributes:viewController.kooNavTitleTextAttributes];
        
  
    }
    
    [self setNavigationBarAlpha:viewController.kooNavBarAlpha];
    [self.navigationBar setNeedsDisplay];
    [self.navigationBar setNeedsLayout];
    [self.navigationBar layoutIfNeeded];
}

- (void)updateStatusBarStyleWithViewController:(UIViewController *)viewController
{
    if (viewController.kooNavBarAlpha == 0)
    {
        if ([self colorBrigntness:viewController.view.backgroundColor] > 0.5)
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        } else
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }
    }
    else
    {
        if ([self colorBrigntness:viewController.kooNavBarTintColor] > 0.5)
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }
        else
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }
    }
}

- (CGFloat)colorBrigntness:(UIColor*)aColor
{
    CGFloat hue, saturation, brigntness, alpha;
    [aColor getHue:&hue saturation:&saturation brightness:&brigntness alpha:&alpha];
    return brigntness;
}

- (UIColor *)getColorWithFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percentComplete:(CGFloat)percentComplete
{
    CGFloat fromRed        = 0.0;
    CGFloat fromGreen      = 0.0;
    CGFloat fromBlue       = 0.0;
    CGFloat fromColorAlpha = 0.0;
    CGFloat toRed        = 0.0;
    CGFloat toGreen      = 0.0;
    CGFloat toBlue       = 0.0;
    CGFloat toColorAlpha = 0.0;
    
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromColorAlpha];
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toColorAlpha];
    
    CGFloat newRed        = fromRed + (toRed - fromRed) * percentComplete;
    CGFloat newGreen      = fromGreen + (toGreen - fromGreen) * percentComplete;
    CGFloat newBlue       = fromBlue + (toBlue - fromBlue) * percentComplete;
    CGFloat newColorAlpha = fromColorAlpha + (toColorAlpha - fromColorAlpha) * percentComplete;
    
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newColorAlpha];
}


- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    if ([context isCancelled]) // 取消了返回手势
    {
        UIViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
        [self updateBarAppearenceWithViewController:fromVC];
    }
    else
    {
        UIViewController *toVC = self.topViewController;
        [self updateBarAppearenceWithViewController:toVC];
    }
}
@end
