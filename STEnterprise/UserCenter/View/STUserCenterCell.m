//
//  STUserCenterCell.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STUserCenterCell.h"

@implementation STUserCenterCell
+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
//        [self addSubviews];
        [self updateConstraints];
//        [self bindsignal];
    }
    return self;
}


@end
