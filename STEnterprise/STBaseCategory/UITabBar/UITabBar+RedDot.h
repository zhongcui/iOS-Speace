//
//  UITabBar+KooIM.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

/**
 解决系统红点过大的问题
 */
@interface UITabBar (RedDot)
- (void)showBadgeOnItemIndex:(int)index totalItem:(int)num;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
