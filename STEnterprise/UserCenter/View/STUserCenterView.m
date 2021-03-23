//
//  STUserCenterView.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STUserCenterView.h"
#import "UIColor+KooAdd.h"
#import <Masonry.h>
#import "STUserCenterCell.h"
#import "KooViewMacro.h"
#import "STUserLoginHeader.h"
#import "STUserUnLoginHeader.h"

@interface STUserCenterView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) STUserLoginHeader *loginHeader;
@property (nonatomic, strong) STUserUnLoginHeader *unLoginHeader;
@end

@implementation STUserCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addsubViews];
        self.backgroundColor = [UIColor whiteColor];
        [self updateConstraints];
    }
    return self;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[STUserCenterCell identifier]];
    if (cell == nil)
    {
        cell = [[STUserCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[STUserCenterCell identifier]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 8)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.f;
}

#pragma mark - UI
-(void)addsubViews
{
    [self addSubview:self.mainView];
}

-(void)updateConstraints
{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(KooStatusBarHeight);
        make.left.right.bottom.mas_equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark - getter
- (UITableView *)mainView
{
    if (!_mainView)
    {
        _mainView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _mainView.tableFooterView = [[UIView alloc] init];
        self.loginHeader = [[STUserLoginHeader alloc]initWithFrame:CGRectMake(0, 0, KooScreenWidth, 103)];
        _mainView.tableHeaderView = self.loginHeader;
    }
    return _mainView;
}

@end
