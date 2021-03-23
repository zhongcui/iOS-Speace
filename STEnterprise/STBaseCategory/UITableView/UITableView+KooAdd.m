//
//  UITableView+KooAdd.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "UITableView+KooAdd.h"

@implementation UITableView (KooAdd)
- (void)koo_scrollToBottom:(BOOL)animation
{
    [self koo_scrollToBottom:animation withDuration:0.1];
}

- (void)koo_scrollToBottom:(BOOL)animation withDuration:(float)duration
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger row = [self numberOfRowsInSection:0] - 1;
        if (row > 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animation];
            self.alpha = 1;
        }
    });
}
@end
