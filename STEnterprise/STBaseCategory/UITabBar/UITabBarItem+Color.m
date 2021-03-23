//
//  UITabBarItem+Color.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//


#import "UITabBarItem+Color.h"
#import "UIColor+KooAdd.h"

@implementation UITabBarItem (Color)

- (void)koo_setBadgeValue:(NSString *)badgeValue {
    
    [self setBadgeValue:badgeValue];//设置角标值
    
    UIColor * color = [UIColor colorWithHexString:@"#FA5740"];//修改成红色
    
    if (@available(iOS 10.0, *)) {
        
        [self setBadgeColor:color]; //iOS10以上可以用此方法修改
        
    } else {
        
        //iOS10以下是图片 如果后期需要可以调用下面方法
    }
}


- (void)customBadgeColorWith:(UIImage *)badgeImage
{
    UIView *tabBarButton = (UIView *)[self performSelector:@selector(view)];
    
    // iOS10以下的版本 角标其实是一张图片，所以我们一直找下去这个图片，然后替换他
    for(UIView *subview in tabBarButton.subviews) {
        NSString *classString = NSStringFromClass([subview class]);
        if([classString rangeOfString:@"UIBadgeView"].location != NSNotFound) {
            for(UIView *badgeSubview in subview.subviews) {
                NSString *badgeSubviewClassString = NSStringFromClass([badgeSubview class]);
                if([badgeSubviewClassString rangeOfString:@"BadgeBackground"].location != NSNotFound) {
                    [badgeSubview setValue:badgeImage forKey:@"image"];
                }
            }
        }
    }
}

@end
