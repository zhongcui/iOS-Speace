//
//  KooViewMacro.h
//  koolearnMotion
//
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#ifndef KooViewMacro_h
#define KooViewMacro_h

#define KooScreenWidth  [[UIScreen mainScreen] bounds].size.width//屏幕宽度
#define KooScreenHeight  [[UIScreen mainScreen] bounds].size.height//屏幕高度
#define KooSafeAreaTopHeightWithTab KooTabBarHeight+KooSafeAreaBottomHeight//带底部导航的安全区域高度
#define KooSafeAreaTopHeightWithNav KooStatusBarHeight+KooNavBarHeight//带顶部导航的安全区域高度


#define KooSafeAreaBottomHeight (KooIsiPhoneX ? 34 : 0)//安全区域底部高度
#define KooStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height//状态栏高度
#define KooNavBarHeight 44//顶部部导航栏高度
#define KooTabBarHeight 44//底部导航栏高度
#define KooBarItemWidth 80.0f//tabBrItem宽

#endif /* KooViewMacro_h */
