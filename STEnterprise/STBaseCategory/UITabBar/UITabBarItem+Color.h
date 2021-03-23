//
//  UITabBarItem+Color.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarItem (Color)


/**
 修改系统红点的色值

 @param badgeValue badgeValue
 */
- (void)koo_setBadgeValue:(NSString *)badgeValue;


@end

NS_ASSUME_NONNULL_END
