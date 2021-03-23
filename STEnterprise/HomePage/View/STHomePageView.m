//
//  STHomePageView.m
//  STEnterprise
//
//  Created by mac on 2021/3/19.
//

#import "STHomePageView.h"
#import <Masonry.h>
#import "UIColor+KooAdd.h"
#import "KooViewMacro.h"
#import "UIView+KooAdd.h"
#import "STCircularProgress.h"
#import "UIButton+ImageTitleSpacing.h"

@interface STHomePageView()
@property (nonatomic, strong) UIView *finacialView;
@property (nonatomic, strong) UIView *finVerLine1;  //侧边竖线
@property (nonatomic, strong) UILabel *finacialTitle;//财务统计标题
@property (nonatomic, strong) UILabel *invoicedLab; //已开票
@property (nonatomic, strong) UILabel *unInvoicLab; //未开票
@property (nonatomic, strong) UILabel *withDrewLab; //已提现
@property (nonatomic, strong) UIView *finVerLine2;  //财务统计竖线
@property (nonatomic, strong) UIView *finVerLine3;
@property (nonatomic, strong) UIView *billView;
@property (nonatomic, strong) UIView *billLine1;    //侧边竖线
@property (nonatomic, strong) UILabel *billTitle;   //运单统计标题
@property (nonatomic, strong) UIView *billLine2;    //运单统计竖线
@property (nonatomic, strong) UIView *billLine3;
@property (nonatomic, strong) UIView *billLine4;
@property (nonatomic, strong) STCircularProgress *totleCir;   //全部
@property (nonatomic, strong) STCircularProgress *runningCir; //进行中
@property (nonatomic, strong) STCircularProgress *waitCir;    //待收货
@property (nonatomic, strong) STCircularProgress *completeCir;//已完成
@property (nonatomic, strong) UILabel *totleLab;
@property (nonatomic, strong) UILabel *runningLab;
@property (nonatomic, strong) UILabel *waitLab;
@property (nonatomic, strong) UILabel *completeLab;
@property (nonatomic, strong) UIView *usedView;
@property (nonatomic, strong) UIView *usedLine1;    //常用功能竖线
@property (nonatomic, strong) UILabel *usedTitle;   //常用功能标题
@property (nonatomic, strong) UIButton *billManage; //运单管理
@property (nonatomic, strong) UIButton *payManage; //支付管理
@property (nonatomic, strong) UIButton *invoiceManage; //开票管理
@property (nonatomic, strong) UIButton *lineManage; //线路维护
@property (nonatomic, strong) UIButton *msgManage; //信息维护
@property (nonatomic, strong) UIButton *carManage; //车辆管理
@end

@implementation STHomePageView

-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        [self configUI];
        [self updateConstraints];
        [self bindSignals];
    }
    return self;
}

#pragma mark - method
-(void)bindSignals
{
    @weakify(self);
    [[self.billManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.billSubject sendNext:nil];
    }];
    
    [[self.payManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.paySubject sendNext:nil];
    }];
    
    [[self.invoiceManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.invoiceSubject sendNext:nil];
    }];
    
    [[self.lineManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.lineSubject sendNext:nil];
    }];
    
    [[self.msgManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.msgSubject sendNext:nil];
    }];
    
    [[self.carManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.carSubject sendNext:nil];
    }];
    
}


-(NSMutableAttributedString *)attributedStringWithText:(NSString *)text
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, text.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length-5, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#222222"] range:NSMakeRange(0, text.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#5C5C5C"] range:NSMakeRange(text.length-5, 5)];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    return attr;
}

-(UIView *)viewWithCorner
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [[UIColor colorWithHexString:@"#0A7BCD"] colorWithAlphaComponent:0.4];
    view.layer.cornerRadius = 2.5;
    view.clipsToBounds = YES;
    return view;
}

-(UIButton *)buttonWithText:(NSString *)text imageNamed:(NSString *)name
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#5C5C5C"] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    return btn;
}
#pragma mark - UI
-(void)configUI
{
    [self addSubview:self.finacialView];
    [self.finacialView addSubview:self.finVerLine1];
    [self.finacialView addSubview:self.finacialTitle];
    [self.finacialView addSubview:self.finVerLine2];
    [self.finacialView addSubview:self.finVerLine3];
    [self.finacialView addSubview:self.invoicedLab];
    [self.finacialView addSubview:self.unInvoicLab];
    [self.finacialView addSubview:self.withDrewLab];
    [self addSubview:self.billView];
    [self.billView addSubview:self.billLine1];
    [self.billView addSubview:self.billTitle];
    [self.billView addSubview:self.billLine2];
    [self.billView addSubview:self.billLine3];
    [self.billView addSubview:self.billLine4];
    [self.billView addSubview:self.totleCir];
    [self.billView addSubview:self.runningCir];
    [self.billView addSubview:self.waitCir];
    [self.billView addSubview:self.completeCir];
    [self.billView addSubview:self.totleLab];
    [self.billView addSubview:self.runningLab];
    [self.billView addSubview:self.waitLab];
    [self.billView addSubview:self.completeLab];
    [self addSubview:self.usedView];
    [self.usedView addSubview:self.usedLine1];
    [self.usedView addSubview:self.usedTitle];
    [self.usedView addSubview:self.billManage];
    [self.usedView addSubview:self.payManage];
    [self.usedView addSubview:self.invoiceManage];
    [self.usedView addSubview:self.lineManage];
    [self.usedView addSubview:self.msgManage];
    [self.usedView addSubview:self.carManage];
}

-(void)updateConstraints
{
    //财务统计模块
    [self.finacialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(KooScreenWidth-32);
        make.height.mas_equalTo(self.finacialView.mas_width).multipliedBy(0.37);
    }];
    
    [self.finVerLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.finacialView).offset(10);
        make.top.mas_equalTo(self.finacialView).offset(12);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(15);
    }];
    
    [self.finacialTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.finVerLine1.mas_right).offset(3);
        make.centerY.mas_equalTo(self.finVerLine1);
    }];
    
    [self.finVerLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.finacialView).offset((KooScreenWidth-32)*0.33);
        make.centerY.mas_equalTo(self.finacialView).offset(2);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(37);
    }];
    
    [self.invoicedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(KooScreenWidth-32)*0.33);
        make.centerY.mas_equalTo(self.finVerLine2).offset(10);
    }];
    
    [self.unInvoicLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.finacialView);
        make.centerY.mas_equalTo(self.invoicedLab);
    }];
    
    [self.finVerLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.finacialView).offset(-(KooScreenWidth-32)*0.33);
        make.centerY.width.height.mas_equalTo(self.finVerLine2);
    }];
    
    [self.withDrewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.invoicedLab);
        make.centerX.mas_equalTo((KooScreenWidth-32)*0.33);
    }];
    
    //运单统计模块
    [self.billView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.finacialView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.finacialView);
        make.height.mas_equalTo(self.finacialView.mas_width).multipliedBy(0.37);
    }];
    
    [self.billLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.billView).offset(12);
        make.width.height.centerX.mas_equalTo(self.finVerLine1);
    }];
    
    [self.billTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.billLine1.mas_right).offset(3);
        make.centerY.mas_equalTo(self.billLine1);
    }];
    
    [self.billLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((KooScreenWidth-32)*0.25);
        make.centerY.mas_equalTo(self.billView).offset(2);
        make.width.height.mas_equalTo(self.finVerLine2);
    }];
    
    [self.billLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.billView);
        make.width.height.centerY.mas_equalTo(self.billLine2);
    }];
    
    [self.billLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-(KooScreenWidth-32)*0.25);
        make.width.height.centerY.mas_equalTo(self.billLine2);
    }];
    
    [self.totleCir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.billLine2);
        make.width.height.mas_equalTo(36);
        make.left.mas_equalTo((KooScreenWidth-32)*0.25*0.5-18);
    }];
    
    [self.runningCir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.billLine2);
        make.width.height.mas_equalTo(self.totleCir);
        make.left.mas_equalTo((KooScreenWidth-32)*0.37-18);
    }];
    
    [self.waitCir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.billLine2);
        make.width.height.mas_equalTo(self.totleCir);
        make.left.mas_equalTo((KooScreenWidth-32)*0.62-18);
    }];
    
    [self.completeCir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.billLine2);
        make.width.height.mas_equalTo(self.totleCir);
        make.left.mas_equalTo((KooScreenWidth-32)*0.87-18);
    }];
    
    [self.totleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.totleCir);
        make.top.mas_equalTo(self.totleCir.mas_bottom).offset(10);
    }];
    
    [self.runningLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.runningCir);
        make.centerY.mas_equalTo(self.totleLab);
    }];
    
    [self.waitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.waitCir);
        make.centerY.mas_equalTo(self.totleLab);
    }];
    
    [self.completeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.completeCir);
        make.centerY.mas_equalTo(self.totleLab);
    }];
    //常用功能模块
    [self.usedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.billView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.finacialView);
        make.height.mas_equalTo(self.finacialView.mas_width).multipliedBy(0.62);
    }];
    
    [self.usedLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usedView).offset(12);
        make.width.height.centerX.mas_equalTo(self.finVerLine1);
    }];
    
    [self.usedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usedLine1.mas_right).offset(3);
        make.centerY.mas_equalTo(self.usedLine1);
    }];
    
    [self.billManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usedTitle.mas_bottom).offset(2);
        make.centerX.mas_equalTo(self.invoicedLab);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(70);
    }];

    [self.payManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.unInvoicLab);
        make.width.top.height.mas_equalTo(self.billManage);
    }];

    [self.invoiceManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.withDrewLab);
        make.width.top.height.mas_equalTo(self.billManage);
    }];

    [self.lineManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.mas_equalTo(self.billManage);
        make.top.mas_equalTo(self.billManage.mas_bottom).offset(2);
    }];

    [self.msgManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.mas_equalTo(self.payManage);
        make.centerY.mas_equalTo(self.lineManage);
    }];

    [self.carManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.mas_equalTo(self.invoiceManage);
        make.centerY.mas_equalTo(self.lineManage);
    }];
    [super updateConstraints];
}

#pragma mark - getter
-(RACSubject *)billSubject
{
    if (!_billSubject)
    {
        _billSubject = [RACSubject subject];
    }
    return _billSubject;
}

-(RACSubject *)paySubject
{
    if (!_paySubject)
    {
        _paySubject = [RACSubject subject];
    }
    return _paySubject;
}

-(RACSubject *)invoiceSubject
{
    if (!_invoiceSubject)
    {
        _invoiceSubject = [RACSubject subject];
    }
    return _invoiceSubject;
}

-(RACSubject *)lineSubject
{
    if (!_lineSubject)
    {
        _lineSubject = [RACSubject subject];
    }
    return _lineSubject;
}

-(RACSubject *)msgSubject
{
    if (!_msgSubject)
    {
        _msgSubject = [RACSubject subject];
    }
    return _msgSubject;
}

-(RACSubject *)carSubject
{
    if (!_carSubject)
    {
        _carSubject = [RACSubject subject];
    }
    return _carSubject;
}

//财务统计模块
-(UIView *)finacialView
{
    if (!_finacialView)
    {
        _finacialView = [[UIView alloc]init];
        _finacialView.backgroundColor = [UIColor whiteColor];
        _finacialView.layer.cornerRadius = 5;
        _finacialView.clipsToBounds = YES;
    }
    return _finacialView;
}

-(UIView *)finVerLine1
{
    if (!_finVerLine1)
    {
        _finVerLine1 = [self viewWithCorner];
    }
    return _finVerLine1;
}

-(UILabel *)finacialTitle
{
    if (!_finacialTitle)
    {
        _finacialTitle = [[UILabel alloc]init];
        _finacialTitle.text = @"财务统计 (万元)";
        _finacialTitle.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _finacialTitle.font = [UIFont systemFontOfSize:15];
    }
    return _finacialTitle;
}

-(UIView *)finVerLine2
{
    if (!_finVerLine2)
    {
        _finVerLine2 = [[UIView alloc]init];
        _finVerLine2.backgroundColor = [[UIColor colorWithHexString:@"#D8D8D8"] colorWithAlphaComponent:0.5];
    }
    return _finVerLine2;
}

-(UIView *)finVerLine3
{
    if (!_finVerLine3)
    {
        _finVerLine3 = [[UIView alloc]init];
        _finVerLine3.backgroundColor = [[UIColor colorWithHexString:@"#D8D8D8"] colorWithAlphaComponent:0.5];
    }
    return _finVerLine3;
}

-(UILabel *)invoicedLab
{
    if (!_invoicedLab)
    {
        _invoicedLab = [[UILabel alloc]init];
        _invoicedLab.attributedText = [self attributedStringWithText:@"￥2345\n已开票金额"];
        _invoicedLab.numberOfLines = 0;
        _invoicedLab.textAlignment = NSTextAlignmentCenter;
    }
    return _invoicedLab;
}

-(UILabel *)unInvoicLab
{
    if (!_unInvoicLab)
    {
        _unInvoicLab = [[UILabel alloc]init];
        _unInvoicLab.attributedText = [self attributedStringWithText:@"￥2345\n未开票金额"];
        _unInvoicLab.numberOfLines = 0;
        _unInvoicLab.textAlignment = NSTextAlignmentCenter;
    }
    return _unInvoicLab;
}

-(UILabel *)withDrewLab
{
    if (!_withDrewLab)
    {
        _withDrewLab = [[UILabel alloc]init];
        _withDrewLab.attributedText = [self attributedStringWithText:@"￥122\n已提现金额"];
        _withDrewLab.numberOfLines = 0;
        _withDrewLab.textAlignment = NSTextAlignmentCenter;
    }
    return _withDrewLab;
}

-(UILabel *)totleLab
{
    if (!_totleLab)
    {
        _totleLab = [[UILabel alloc]init];
        _totleLab.text = @"全部";
        _totleLab.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _totleLab.font = [UIFont systemFontOfSize:12];
    }
    return _totleLab;
}

-(UILabel *)runningLab
{
    if (!_runningLab)
    {
        _runningLab = [[UILabel alloc]init];
        _runningLab.text = @"进行中";
        _runningLab.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _runningLab.font = [UIFont systemFontOfSize:12];
    }
    return _runningLab;
}

-(UILabel *)waitLab
{
    if (!_waitLab)
    {
        _waitLab = [[UILabel alloc]init];
        _waitLab.text = @"待收货";
        _waitLab.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _waitLab.font = [UIFont systemFontOfSize:12];
    }
    return _waitLab;
}

-(UILabel *)completeLab
{
    if (!_completeLab)
    {
        _completeLab = [[UILabel alloc]init];
        _completeLab.text = @"已完成";
        _completeLab.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _completeLab.font = [UIFont systemFontOfSize:12];
    }
    return _completeLab;
}
//运单统计模块
-(UIView *)billView
{
    if (!_billView)
    {
        _billView = [[UIView alloc]init];
        _billView.backgroundColor = [UIColor whiteColor];
        _billView.layer.cornerRadius = 5;
        _billView.clipsToBounds = YES;
    }
    return _billView;
}

-(UIView *)billLine1
{
    if (!_billLine1)
    {
        _billLine1 = [self viewWithCorner];
    }
    return _billLine1;
}

-(UILabel *)billTitle
{
    if (!_billTitle)
    {
        _billTitle = [[UILabel alloc]init];
        _billTitle.text = @"运单统计";
        _billTitle.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _billTitle.font = [UIFont systemFontOfSize:15];
    }
    return _billTitle;
}

-(UIView *)billLine2
{
    if (!_billLine2)
    {
        _billLine2 = [[UIView alloc]init];
        _billLine2.backgroundColor = [[UIColor colorWithHexString:@"#D8D8D8"] colorWithAlphaComponent:0.5];
    }
    return _billLine2;
}

-(UIView *)billLine3
{
    if (!_billLine3)
    {
        _billLine3 = [[UIView alloc]init];
        _billLine3.backgroundColor = [[UIColor colorWithHexString:@"#D8D8D8"] colorWithAlphaComponent:0.5];
    }
    return _billLine3;
}

-(UIView *)billLine4
{
    if (!_billLine4)
    {
        _billLine4 = [[UIView alloc]init];
        _billLine4.backgroundColor = [[UIColor colorWithHexString:@"#D8D8D8"] colorWithAlphaComponent:0.5];
    }
    return _billLine4;
}

-(STCircularProgress *)totleCir
{
    if (!_totleCir)
    {
        _totleCir = [[STCircularProgress alloc]initWithFrame:CGRectMake(0, 0, 36, 36) backColor:[UIColor colorWithHexString:@"#F43A06"] lineWidth:3];
        [_totleCir setProgress:60];
    }
    return _totleCir;
}

-(STCircularProgress *)runningCir
{
    if (!_runningCir)
    {
        _runningCir = [[STCircularProgress alloc]initWithFrame:CGRectMake(0, 0, 36, 36) backColor:[UIColor colorWithHexString:@"#0389C6"] lineWidth:3];
        [_runningCir setProgress:40];
    }
    return _runningCir;
}

-(STCircularProgress *)waitCir
{
    if (!_waitCir)
    {
        _waitCir = [[STCircularProgress alloc]initWithFrame:CGRectMake(0, 0, 36, 36) backColor:[UIColor colorWithHexString:@"#F99B1D"] lineWidth:3];
        [_waitCir setProgress:10];
    }
    return _waitCir;
}

-(STCircularProgress *)completeCir
{
    if (!_completeCir)
    {
        _completeCir = [[STCircularProgress alloc]initWithFrame:CGRectMake(0, 0, 36, 36) backColor:[UIColor colorWithHexString:@"#8BC17D"] lineWidth:3];
        [_completeCir setProgress:10];
    }
    return _completeCir;
}
//用户常用功能模块
-(UIView *)usedView
{
    if (!_usedView)
    {
        _usedView = [[UIView alloc]init];
        _usedView.backgroundColor = [UIColor whiteColor];
        _usedView.layer.cornerRadius = 5;
        _usedView.clipsToBounds = YES;
    }
    return _usedView;
}

-(UIView *)usedLine1
{
    if (!_usedLine1)
    {
        _usedLine1 = [self viewWithCorner];
    }
    return _usedLine1;
}

-(UILabel *)usedTitle
{
    if (!_usedTitle)
    {
        _usedTitle = [[UILabel alloc]init];
        _usedTitle.text = @"常用功能";
        _usedTitle.textColor = [UIColor colorWithHexString:@"#5C5C5C"];
        _usedTitle.font = [UIFont systemFontOfSize:15];
    }
    return _usedTitle;
}

-(UIButton *)billManage
{
    if (!_billManage)
    {
        _billManage = [self buttonWithText:@"运单管理" imageNamed:@"home_bill"];
    }
    return _billManage;
}

-(UIButton *)payManage
{
    if (!_payManage)
    {
        _payManage = [self buttonWithText:@"支付管理" imageNamed:@"home_pay"];
        
    }
    return _payManage;
}

-(UIButton *)invoiceManage
{
    if (!_invoiceManage)
    {
        _invoiceManage = [self buttonWithText:@"开票管理" imageNamed:@"home_invoice"];
    }
    return _invoiceManage;
}

-(UIButton *)lineManage
{
    if (!_lineManage)
    {
        _lineManage = [self buttonWithText:@"线路维护" imageNamed:@"home_line"];
    }
    return _lineManage;
}

-(UIButton *)msgManage
{
    if (!_msgManage)
    {
        _msgManage = [self buttonWithText:@"信息维护" imageNamed:@"home_msg"];
    }
    return _msgManage;
}

-(UIButton *)carManage
{
    if (!_carManage)
    {
        _carManage = [self buttonWithText:@"车辆管理" imageNamed:@"home_car"];
        
    }
    return _carManage;
}
@end
