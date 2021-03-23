//
//  STHomePageController.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "STHomePageController.h"
#import "STHomePageView.h"
#import "UIColor+KooAdd.h"
#import <Masonry/Masonry.h>
#import "UIViewController+KooNavBar.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "KooViewMacro.h"
#import "STHomeNavView.h"
#import "STMessageController.h"
#import "STBillManageController.h"
#import "STPayManageController.h"
#import "STInvoiceManageController.h"
#import "STMsgSafeguardController.h"
#import "STLineSafeguardController.h"
#import "STCarManageController.h"

@interface STHomePageController ()
@property (nonatomic, strong) STHomePageView *pageView;
@property (nonatomic, strong) STHomeNavView *leftNavView;
@property (nonatomic, strong) UIButton *navRightView;
@end

@implementation STHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addsubViews];
    [self updateViewConstraints];
    [self setUpNavBar];
    [self bindSignals];
}

-(void)bindSignals
{
    @weakify(self);
    //消息
    [[self.navRightView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STMessageController new] animated:YES];
    }];
    //运单管理
    [self.pageView.billSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STBillManageController new] animated:YES];
    }];
    //支付管理
    [self.pageView.paySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STPayManageController new] animated:YES];
    }];
    //开票管理
    [self.pageView.invoiceSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STInvoiceManageController new] animated:YES];
    }];
    //线路维护
    [self.pageView.lineSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STLineSafeguardController new] animated:YES];
    }];
    //信息维护
    [self.pageView.msgSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STMsgSafeguardController new] animated:YES];
    }];
    //车辆管理
    [self.pageView.carSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[STCarManageController new] animated:YES];
    }];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}


-(void)setUpNavBar
{
    self.navigationController.navigationBar.translucent = NO;
    STHomeNavView *leftBtnView = [[STHomeNavView alloc] initWithFrame:CGRectMake(0, 0, KooScreenWidth*0.3, 44)];
    self.leftNavView = leftBtnView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightView];
    self.kooNavBackImage = [UIImage imageNamed:@"nav_back"];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - UI
-(void)addsubViews
{
    [self.view addSubview:self.pageView];
}

-(void)updateViewConstraints
{
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super updateViewConstraints];
}

#pragma mark - Nav
- (void)setupNavBar
{
    
}

#pragma mark - getter
-(STHomePageView *)pageView
{
    if (!_pageView)
    {
        self.pageView = [[STHomePageView alloc]init];
    }
    return _pageView;
}

-(UIButton *)navRightView
{
    if (!_navRightView)
    {
        _navRightView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _navRightView.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        [_navRightView setImage:[UIImage imageNamed:@"nav_msg"] forState:UIControlStateNormal];
        _navRightView.adjustsImageWhenHighlighted = NO;
    }
    return _navRightView;
}
@end
