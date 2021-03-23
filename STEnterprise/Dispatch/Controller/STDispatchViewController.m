//
//  STDispatchViewController.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "STDispatchViewController.h"
#import "STDispatchView.h"
#import <Masonry.h>

@interface STDispatchViewController ()
@property (nonatomic, strong) STDispatchView *pageView;
@end

@implementation STDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"发货";
    [self addsubViews];
    [self updateViewConstraints];
}

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

-(STDispatchView *)pageView
{
    if (!_pageView)
    {
        _pageView = [[STDispatchView alloc]init];
    }
    return _pageView;
}

@end
