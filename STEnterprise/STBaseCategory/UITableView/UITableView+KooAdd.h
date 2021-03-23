//
//  UITableView+KooAdd.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KooAdd)

/**
 滚动到底部
 @param animation 是否带动画
 */
- (void)koo_scrollToBottom:(BOOL)animation;

/**
 滚动到底部
 @param animation 是否带动画
 @param duration 动画时长
 */
- (void)koo_scrollToBottom:(BOOL)animation withDuration:(float)duration;

@end

NS_ASSUME_NONNULL_END
