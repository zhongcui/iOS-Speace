//
//  UIViewController+KooNavBar.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+KooNavAlpha.h"

@interface UIViewController (KooNavBar)
/**
 导航栏透明度
 */
@property (nonatomic, assign) CGFloat kooNavBarAlpha;

/**
 导航栏背景色
 */
@property (nonatomic, strong) UIColor *kooNavBarTintColor;

/**
 操作按钮颜色
 */
@property (nonatomic, strong) UIColor *kooNavTintColor;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *kooNavTitileColor;

/**
 标题属性
 */
@property (nonatomic, strong) NSDictionary *kooNavTitleTextAttributes;


/**
 返回按钮图片
 */
@property (nonatomic, strong) UIImage *kooNavBackImage;

@end
