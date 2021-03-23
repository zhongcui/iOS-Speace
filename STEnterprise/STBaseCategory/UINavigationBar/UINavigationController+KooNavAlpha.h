//
//  UINavigationController+KooAlpha.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (KooNavAlpha)<UINavigationBarDelegate,UINavigationControllerDelegate>
// 设置导航栏透明度
- (void)setNavigationBarAlpha:(CGFloat)alpha;
@end
