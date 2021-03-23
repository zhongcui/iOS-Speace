//
//  UIScrollView+KooLearnUIScrollView.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UIScrollView+KooRefresh.h"

@implementation UIScrollView (KooRefresh)

- (void)kl_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
{
    MJRefreshGifHeader *mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    mj_header.stateLabel.hidden = YES;
    mj_header.mj_h = 38.f;
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i <= 22; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"bird%d", i];
        UIImage *loadImage = [UIImage imageNamed:imageName];
        UIImage *image = [loadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [idleImages addObject:image];
    }
    // 设置普通状态的动画图片
    [mj_header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [mj_header setImages:idleImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [mj_header setImages:idleImages forState:MJRefreshStateRefreshing];
    
    self.mj_header = mj_header;
}

- (void)kl_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshAutoStateFooter *mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:refreshingBlock];
    self.mj_footer = mj_footer;
}

@end
