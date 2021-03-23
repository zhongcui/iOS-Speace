//
//  STBillManageView.m
//  STEnterprise
//
//  Created by mac on 2021/3/23.
//

#import "STBillManageView.h"
#import <Masonry.h>
#import "UIColor+KooAdd.h"
#import "UIView+KooAdd.h"

@implementation STBillManageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
        self.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        [self updateConstraints];
    }
    return self;
}

#pragma mark - method


#pragma mark - UI
-(void)configUI
{
    
}


-(void)updateConstraints
{
    
    [super updateConstraints];
}
#pragma mark - getter

@end
