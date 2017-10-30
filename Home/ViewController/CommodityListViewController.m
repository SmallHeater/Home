//
//  CommodityListViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityListViewController.h"
#import "CategorySelectViewController.h"
#import "CommodityTableViewCell.h"
#import "CommodityDataManager.h"
#import "LogInViewController.h"
#import "SHFMDBManager.h"


@interface CommodityListViewController ()
//录入按钮
@property (nonatomic,strong) UIButton * rewardBtn;
@end

@implementation CommodityListViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backBtn.hidden = YES;
    self.navigationBar.titleLabel.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar addSubview:self.rewardBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"物品清单页面"];
    self.tabBarController.tabBar.hidden = NO;
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].dataArray];
    NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selecTable];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"物品清单页面"];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理函数
#pragma mark  ----  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityTableViewCell"];
    if (!cell) {
        
        cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommodityTableViewCell"];
    }
    cell.commodityModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark  ----  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120.5;
}

#pragma mark  ----  自定义函数
-(void)rewardBtnClicked:(UIButton *)btn{
    
    CategorySelectViewController * categorySelectVC = [[CategorySelectViewController alloc] init];
    [self.navigationController pushViewController:categorySelectVC animated:YES];
    
//    LogInViewController * loginVC = [[LogInViewController alloc] init];
//    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark  ----  懒加载
-(UIButton *)rewardBtn{
    if (!_rewardBtn) {
        
        _rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rewardBtn.frame = CGRectMake(SCREENWIDTH - 44 - 20, 20, 44, 44);
        [_rewardBtn setTitle:@"录入" forState:UIControlStateNormal];
        [_rewardBtn addTarget:self action:@selector(rewardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewardBtn;
}
@end
