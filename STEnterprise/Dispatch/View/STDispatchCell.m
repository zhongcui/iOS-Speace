//
//  STDispatchCell.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STDispatchCell.h"
#import <Masonry.h>
#import "UIColor+KooAdd.h"

@interface STDispatchCell()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIImageView *rightArrow;
@end

@implementation STDispatchCell

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
        [self addSubviews];
        [self updateConstraints];
//        [self bindsignal];
    }
    return self;
}

-(void)setCellImgNamed:(NSString *)name title:(NSString *)title detail:(NSString *)detail
{
    self.imgView.image = [UIImage imageNamed:name];
    self.titleLab.text = title;
    self.detailLab.text = detail;
}


#pragma mark - UI
-(void)addSubviews
{
    [self addSubview:self.imgView];
    [self addSubview:self.titleLab];
    [self addSubview:self.detailLab];
    [self addSubview:self.rightArrow];
}

-(void)updateConstraints
{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(26);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(24);
        make.top.mas_equalTo(self).offset(19);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(7);
    }];
    
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-16);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(28);
    }];
    [super updateConstraints];
}

#pragma mark - getter
-(UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normal_dispatch"]];
    }
    return _imgView;
}

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor colorWithHexString:@"#222222"];
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    return _titleLab;
}

-(UILabel *)detailLab
{
    if (!_detailLab)
    {
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _detailLab.font = [UIFont systemFontOfSize:14];
    }
    return _detailLab;
}

-(UIImageView *)rightArrow
{
    if (!_rightArrow)
    {
        _rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }
    return _rightArrow;
}
@end
