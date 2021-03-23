//
//  STUserUnLoginHeader.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STUserUnLoginHeader.h"
#import "UIColor+KooAdd.h"
#import "KooViewMacro.h"
#import <Masonry.h>

@interface STUserUnLoginHeader()
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *tipLab;
@end

@implementation STUserUnLoginHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addsubViews];
        [self updateConstraints];
        [self bindSignals];
    }
    return self;
}

-(void)bindSignals
{
    @weakify(self);
    
}

#pragma mark - UI
-(void)addsubViews
{
    [self addSubview:self.userImg];
    [self addSubview:self.tipLab];
}

-(void)updateConstraints
{
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.top.mas_equalTo(self).offset(10);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userImg);
        make.left.mas_equalTo(self.userImg.mas_right).offset(15);
    }];

    
    [super updateConstraints];
}

#pragma mark - getter
-(UIImageView *)userImg
{
    if (!_userImg)
    {
        _userImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_img"]];
    }
    return _userImg;
}

-(UILabel *)tipLab
{
    if (!_tipLab)
    {
        _tipLab = [[UILabel alloc]init];
        _tipLab.text = @"去登陆";
        _tipLab.textColor = [UIColor colorWithHexString:@"#303030"];
        _tipLab.font = [UIFont systemFontOfSize:18];
    }
    return _tipLab;
}

@end
