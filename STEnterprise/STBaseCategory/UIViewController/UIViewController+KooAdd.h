//
//  UIViewController+KooNavBar.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
 
@optional
 
/**
 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
 @return <#return value description#>
 */
-(BOOL)navigationShouldPopOnBackButton;
 
@end
 
 
@interface UIViewController (KooAdd)<BackButtonHandlerProtocol>
 
- (void)popAllPresentedController;

@end
