//
//  STUserLoginHeader.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STUserLoginHeader.h"
#import "UIColor+KooAdd.h"
#import "KooViewMacro.h"
#import <Masonry.h>

@interface STUserLoginHeader()
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *mobileNum;
@property (nonatomic, strong) UIButton *codeBtn;
@end

@implementation STUserLoginHeader

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
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.codeJumpSubject sendNext:nil];
    }];
}

#pragma mark - UI
-(void)addsubViews
{
    [self addSubview:self.userImg];
    [self addSubview:self.userName];
    [self addSubview:self.mobileNum];
    [self addSubview:self.codeBtn];
}

-(void)updateConstraints
{
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.top.mas_equalTo(self).offset(10);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userImg);
        make.left.mas_equalTo(self.userImg.mas_right).offset(15);
        make.width.mas_equalTo(KooScreenWidth*0.53);
    }];
    
    [self.mobileNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName);
        make.top.mas_equalTo(self.userName.mas_bottom).offset(10);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.mas_equalTo(self).offset(-6);
        make.centerY.mas_equalTo(self);
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

-(UILabel *)userName
{
    if (!_userName)
    {
        _userName = [[UILabel alloc]init];
        _userName.text = @"安徽神通物联网科技集团有限公司";
        _userName.textColor = [UIColor colorWithHexString:@"#303030"];
        _userName.font = [UIFont systemFontOfSize:18];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.numberOfLines = 2;
        _userName.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _userName;
}

-(UILabel *)mobileNum
{
    if (!_mobileNum)
    {
        _mobileNum = [[UILabel alloc]init];
        _mobileNum.text = @"150****7878";
        _mobileNum.textColor = [UIColor colorWithHexString:@"#5A5A5A"];
        _mobileNum.font = [UIFont systemFontOfSize:14];
    }
    return _mobileNum;
}

-(UIButton *)codeBtn
{
    if (!_codeBtn)
    {
        _codeBtn = [[UIButton alloc]init];
        [_codeBtn setImage:[UIImage imageNamed:@"code_header"] forState:UIControlStateNormal];
        [_codeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return _codeBtn;
}

@end
