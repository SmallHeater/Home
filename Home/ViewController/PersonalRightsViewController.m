//
//  QuanyiViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsViewController.h"
#import "SHPlainTableView.h"
#import "PersonalRightsRewardingViewController.h"
#import "CommodityDataManager.h"
#import "SHFMDBManager.h"


@interface PersonalRightsViewController ()
//录入按钮
@property (nonatomic,strong) UIButton * rewardBtn;

@property (nonatomic,strong) SHPlainTableView * tableView;
@end

@implementation PersonalRightsViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar addSubview:self.rewardBtn];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"个人权益列表页面"];
    
    
    if ([CommodityDataManager sharedManager].personalRightsArray.count == 0) {
        
        NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selectPersonalRightsTable];
        if (dataArray.count == 0) {
            
            [self.view addSubview:self.noDataView];
        }
        else{
            
            [self.noDataView removeFromSuperview];
        }
        [[CommodityDataManager sharedManager].personalRightsArray addObjectsFromArray:dataArray];
        [self.tableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].personalRightsArray];
    }
    else{
        
        [self.noDataView removeFromSuperview];
        [self.tableView.dataArray removeAllObjects];
        [self.tableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].personalRightsArray];
    }
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"个人权益列表页面"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  自定义函数
-(void)rewardBtnClicked:(UIButton *)btn{
    
    PersonalRightsRewardingViewController * personalRightsVC = [[PersonalRightsRewardingViewController alloc] init];
    [self.navigationController pushViewController:personalRightsVC animated:YES];
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

-(SHPlainTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHPlainTableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) andType:PersonalRightsTableView];
    }
    return _tableView;
}
@end
