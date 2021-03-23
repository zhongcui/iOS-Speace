//
//  UIScrollView+KooAdd.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (KooAdd)

/**
 滚动到顶部
 @param animated 是否带动画
 */
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 滚动到底部
 @param animated 是否带动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 滚动到最左侧
 @param animated 是否带动画
 */
- (void)scrollToLeftAnimated:(BOOL)animated;

/**
 滚动到最右侧
 @param animated 是否带动画
 */
- (void)scrollToRightAnimated:(BOOL)animated;

/**
 是否在最底部
 @return YES：在最底部 NO：不在最底部
 */
- (BOOL)scrollViewIsAtBottom;

@end

NS_ASSUME_NONNULL_END
