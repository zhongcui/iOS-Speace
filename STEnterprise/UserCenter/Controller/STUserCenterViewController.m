//
//  STUserCenterViewController.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "STUserCenterViewController.h"
#import "STUserCenterView.h"
#import <Masonry.h>

@interface STUserCenterViewController ()
@property (nonatomic, strong) STUserCenterView *pageView;
@end

@implementation STUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBarHidden = YES;
    [self addsubViews];
    [self updateViewConstraints];
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

#pragma mark - getter
-(STUserCenterView *)pageView
{
    if (!_pageView)
    {
        _pageView = [[STUserCenterView alloc]init];
    }
    return _pageView;
}
@end
