//
//  STHomeNavView.m
//  STEnterprise
//
//  Created by mac on 2021/3/20.
//

#import "STHomeNavView.h"
#import <Masonry.h>
#import "UIColor+KooAdd.h"
#import "KooViewMacro.h"

@interface STHomeNavView()
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIImageView *userImg;
@end

@implementation STHomeNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self updateConstraints];
    }
    return self;
}

-(void)setUserInfo:(NSString *)info
{
    self.infoLab.text = info;
}

#pragma mark - UI
-(void)configUI
{
    [self addSubview:self.userImg];
    [self addSubview:self.infoLab];
}

-(void)updateConstraints
{
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.left.centerY.mas_equalTo(self);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_right).offset(4);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(KooScreenWidth*0.28);
    }];
    
    [super updateConstraints];
}

#pragma mark - getter
-(UILabel *)infoLab
{
    if (!_infoLab)
    {
        _infoLab = [[UILabel alloc]init];
        _infoLab.text = @"安徽神通物联网科技有限公司";
        _infoLab.textColor = [UIColor colorWithHexString:@"#303030"];
        _infoLab.font = [UIFont systemFontOfSize:13];
        _infoLab.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _infoLab;
}

-(UIImageView *)userImg
{
    if (!_userImg)
    {
        _userImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_img"]];
    }
    return _userImg;
}
@end
