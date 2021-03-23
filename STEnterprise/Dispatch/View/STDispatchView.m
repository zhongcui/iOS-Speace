//
//  STDispatchView.m
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import "STDispatchView.h"
#import "UIColor+KooAdd.h"
#import <Masonry.h>
#import "STDispatchCell.h"

@interface STDispatchView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listView;
@end

@implementation STDispatchView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [self addsubViews];
        [self updateConstraints];
    }
    return self;
}

-(void)addsubViews
{
    [self addSubview:self.listView];
}

-(void)updateConstraints
{
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super updateConstraints];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STDispatchCell *cell = [tableView dequeueReusableCellWithIdentifier:[STDispatchCell identifier]];
    if (cell == nil)
    {
        cell = [[STDispatchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[STDispatchCell identifier]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *imgArr = [NSArray arrayWithObjects:@"normal_dispatch",@"plan_dispatch", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"普通发货（指派司机）",@"计划发货（司机承接)", nil];
    NSArray *detailArr = [NSArray arrayWithObjects:@"批量指派司机下单",@"批量计划下单司机承接", nil];
    [cell setCellImgNamed:imgArr[indexPath.section] title:titleArr[indexPath.section] detail:detailArr[indexPath.section]];
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

#pragma mark - getter
- (UITableView *)listView
{
    if (!_listView)
    {
        _listView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.tableFooterView = [[UIView alloc] init];
        [_listView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _listView;
}

@end
