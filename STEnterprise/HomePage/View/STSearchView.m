//
//  STSearchView.m
//  STEnterprise
//
//  Created by mac on 2021/3/23.
//

#import "STSearchView.h"
#import <Masonry.h>
#import "UIColor+KooAdd.h"
#import "UIView+KooAdd.h"

@interface STSearchView()
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation STSearchView

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
    [self addSubview:self.searchView];
    [self addSubview:self.searchImg];
    [self addSubview:self.searchField];
    [self addSubview:self.searchBtn];
}


-(void)updateConstraints
{
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-16);
    }];
    [super updateConstraints];
}
#pragma mark - getter
-(UIView *)searchView
{
    if (!_searchView)
    {
        _searchView = [[UIView alloc]init];
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchView.layer.cornerRadius = 5;
        _searchView.clipsToBounds = YES;
    }
    return _searchView;
}

-(UIImageView *)searchImg
{
    if (!_searchImg)
    {
        _searchImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _searchImg.backgroundColor = [UIColor orangeColor];
    }
    return _searchImg;
}

-(UITextField *)searchField
{
    if (!_searchField)
    {
        _searchField = [[UITextField alloc]init];
        _searchField.font = [UIFont systemFontOfSize:14];
        _searchField.textColor = [UIColor colorWithHexString:@"#222222"];
        _searchField.placeholder = @"司机姓名、手机、车牌";
        UILabel * textLbl = [_searchField valueForKey:@"placeholderLabel"];
        textLbl.textColor = [UIColor colorWithHexString:@"#9e9e9e"];
        _searchField.textAlignment = NSTextAlignmentLeft;
        _searchField.borderStyle = UITextBorderStyleNone;
        
    }
    return _searchField;
}

-(UIButton *)searchBtn
{
    if (!_searchBtn)
    {
        _searchBtn = [[UIButton alloc]init];
        _searchBtn.backgroundColor = [UIColor colorWithHexString:@"#FFDD3A"];
        _searchBtn.layer.cornerRadius = 5;
        _searchBtn.clipsToBounds = YES;
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _searchBtn.adjustsImageWhenHighlighted = NO;
    }
    return _searchBtn;
}
@end
