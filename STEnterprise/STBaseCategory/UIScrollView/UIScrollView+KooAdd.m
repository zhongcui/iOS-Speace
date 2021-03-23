//
//  UIScrollView+KooAdd.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UIScrollView+KooAdd.h"

@implementation UIScrollView (KooAdd)

- (void)scrollToTopAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

- (BOOL)scrollViewIsAtBottom
{
    CGFloat bottomOffset = self.contentSize.height - self.contentOffset.y - self.frame.size.height;
    return  bottomOffset < 1;
}

@end
