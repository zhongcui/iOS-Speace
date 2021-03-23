//
//  UIScrollView+KooLearnUIScrollView.h
//  koolearnMotion
//
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (KooRefresh)

/**
 *  下拉刷新
 */
- (void)kl_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 *  上拉加载
 */
- (void)kl_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;


@end
