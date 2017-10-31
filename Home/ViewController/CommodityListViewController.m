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
//苹果自带内容索引
#import <CoreSpotlight/CoreSpotlight.h>

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
    [self saveApplyListWithArray:dataArray];
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

#pragma mark  ----  添加内容索引
-(void)saveApplyListWithArray:(NSArray *)arr{
    
    NSMutableArray * tempStoreModelArray = [[NSMutableArray alloc] init];
    [tempStoreModelArray addObjectsFromArray:arr];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray <CSSearchableItem *> * searchableItem = [[NSMutableArray alloc] init];
        
        if (tempStoreModelArray.count > 0) {
            
            for (NSDictionary * dic in tempStoreModelArray) {
                
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    
                    CSSearchableItemAttributeSet * attritable = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"image"];
                    attritable.title = dic[@"storeName"];
                    
                    NSString * storeState;
                    if ([dic[@"auditStatus"] intValue] == 0) {
                        
                        storeState = @"申请中";
                    }
                    else{
                        
                        storeState = @"审核中";
                    }
                    
                    attritable.contentDescription = storeState;
                    
                    NSString * identifier = [[NSString alloc] initWithFormat:@"ApplyForSettled/%@",dic[@"storeId"]];
                    
                    CSSearchableItem * item = [[CSSearchableItem alloc] initWithUniqueIdentifier:identifier domainIdentifier:@"storeList" attributeSet:attritable];
                    [searchableItem addObject:item];
                }
            }
            
            //注入
            [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItem completionHandler:^(NSError * _Nullable error) {
                
                if (error) {
                    
                    NSLog(@"注入错误：%@",error);
                }
            }];
        }
    });
}

//删除所有内容索引
-(void)deleteAll{

    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
