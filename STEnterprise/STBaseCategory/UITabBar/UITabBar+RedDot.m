//
//  UITabBar+KooIM.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UITabBar+RedDot.h"
#import "UIColor+KooAdd.h"

@implementation UITabBar (RedDot)

- (void)showBadgeOnItemIndex:(int)index totalItem:(int)num
{
    if (index >= num) {
        return;
    }
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor colorWithHexString:@"FA5740"];//颜色：红色FF686B
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    CGFloat x = [self getTabBarItemXWithindex:index];
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);//圆形大小为10，产品要求改为8
    [self addSubview:badgeView];
}

//- (void)showBadgeOnItemIndex:(int)index totalItem:(int)num
//{
//    //移除之前的小红点
//    [self removeBadgeOnItemIndex:index];
//
//    //新建小红点
//    UIView *badgeView = [[UIView alloc]init];
//    badgeView.tag = 888 + index;
//    badgeView.layer.cornerRadius = 5;//圆形
//    badgeView.backgroundColor = [UIColor colorWithHexString:@"FF686B"];//颜色：红色
//    CGRect tabFrame = self.frame;
//
//    //确定小红点的位置
//    float percentX = (index +0.6) / num;
//    CGFloat x = ceilf(percentX * tabFrame.size.width);
//    CGFloat y = ceilf(0.1 * tabFrame.size.height);
//    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
//    [self addSubview:badgeView];
//}



//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index 
{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index
{
    //按照tag值进行移除
    for (UIView *subView in self.subviews)
    {
        if (subView.tag == 888+index)
        {
            [subView removeFromSuperview];
        }
    }
}


- (CGFloat)getTabBarItemXWithindex:(NSInteger)index
{
    //遍历出tabBarItems
    NSMutableArray *tabBarItems = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
            [tabBarItems addObject:view];
        }
    }
    
    UIView *tabBarButton = nil;
    UIView *tabBarImageView = nil;
    
    if (tabBarItems.count) {
        //根据frame的X从小到大对tabBarItems进行排序
        NSArray *sortedTabBarItems= [tabBarItems sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2){
            return [@(view1.frame.origin.x) compare:@(view2.frame.origin.x)];
        }];
        
        tabBarButton = sortedTabBarItems[index];
        
        for (UIView *view in tabBarButton.subviews) {
            if ([NSStringFromClass([view class]) isEqualToString:@"UITabBarSwappableImageView"]) {
                tabBarImageView = view;
                break;
            }
        }
    }
    
    CGFloat x = 0;
    
    if (tabBarImageView) {
        x = CGRectGetMinX(tabBarButton.frame) + CGRectGetMaxX(tabBarImageView.frame) - 3;
    }else {
        float percentX = (index +0.6) / self.items.count;
        x = ceilf(percentX * self.frame.size.width);
    }
    
    return x;
}

@end
