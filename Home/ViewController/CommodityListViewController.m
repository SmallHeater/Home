//
//  CommodityListViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityListViewController.h"
#import "CategorySelectViewController.h"
#import "CommodityDataManager.h"
#import "LogInViewController.h"
#import "SHFMDBManager.h"
//苹果自带内容索引
#import <CoreSpotlight/CoreSpotlight.h>
#import "CommodityModel.h"
#import "SHPlainTableView.h"


@interface CommodityListViewController ()
//录入按钮
@property (nonatomic,strong) UIButton * rewardBtn;
//有无保质期选择view
@property (nonatomic,strong) UIView * headerView;

@property (nonatomic,strong) SHPlainTableView * commodityTableView;

@end

@implementation CommodityListViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.titleLabel.text = @"物品列表";
    [self.navigationBar addSubview:self.rewardBtn];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.commodityTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"物品清单页面"];
    
    if ([CommodityDataManager sharedManager].hasShelfCommodityDataArray.count == 0) {
        
        NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selectCommodityTable];
        NSMutableArray * hasShelfDataArray = [[NSMutableArray alloc] init];
        NSMutableArray * noShelfDataArray = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0 ; i < dataArray.count; i++) {
            
            CommodityModel * model = dataArray[i];
            if (model.hasShelfLife) {
                
                [hasShelfDataArray addObject:model];
            }
            else{
                
                [noShelfDataArray addObject:model];
            }
        }
        
        if (hasShelfDataArray.count == 0) {
            
            self.noDataView.frame = CGRectMake(0, 114, SCREENWIDTH, SCREENHEIGHT - 104);
            [self.view addSubview:self.noDataView];
        }
        else{
            
            [self.noDataView removeFromSuperview];
            [[CommodityDataManager sharedManager].hasShelfCommodityDataArray addObjectsFromArray:hasShelfDataArray];
            [self.commodityTableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].hasShelfCommodityDataArray];
        }
        [[CommodityDataManager sharedManager].noShelfCommodityDataArray addObjectsFromArray:noShelfDataArray];
    }
    else{
        
        [self.noDataView removeFromSuperview];
        [self.commodityTableView.dataArray removeAllObjects];
        [self.commodityTableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].hasShelfCommodityDataArray];
    }
    [self.commodityTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"物品清单页面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理函数

#pragma mark  ----  自定义函数
//录入按钮的响应
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
    arr = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray <CSSearchableItem *> * searchableItem = [[NSMutableArray alloc] init];
        
        if (tempStoreModelArray.count > 0) {
            
            for (CommodityModel * model in tempStoreModelArray) {
                
                CSSearchableItemAttributeSet * attritable = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"image"];
                attritable.title = model.commodityName;
                
                NSString * storeState;
                if (model.hasShelfLife) {
                    
                    storeState = model.shelfLife;
                }
                else{
                    
                    storeState = @"不过期";
                }
                
                attritable.contentDescription = storeState;
                
                NSString * identifier = [[NSString alloc] initWithFormat:@"SelectedCommodity/%@",model.commodityID];
                
                CSSearchableItem * item = [[CSSearchableItem alloc] initWithUniqueIdentifier:identifier domainIdentifier:@"CommodityList" attributeSet:attritable];
                [searchableItem addObject:item];
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
            NSLog(@"删除所有内容检索失败：%@", error.localizedDescription);
        }
    }];
}

-(void)controlClicked:(UISegmentedControl *)control{
    
    if (control.selectedSegmentIndex == 0) {
        
        [self.commodityTableView.dataArray removeAllObjects];
        if ([CommodityDataManager sharedManager].hasShelfCommodityDataArray.count > 0) {
            
            [self.noDataView removeFromSuperview];
            self.commodityTableView.type = CommodityWithShelfTableView;
            [self.commodityTableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].hasShelfCommodityDataArray];
        }
        else{
            
            [self.view addSubview:self.noDataView];
        }
    }
    else if (control.selectedSegmentIndex == 1){
        
        [self.commodityTableView.dataArray removeAllObjects];
        if ([CommodityDataManager sharedManager].noShelfCommodityDataArray.count > 0) {
            
            [self.noDataView removeFromSuperview];
            self.commodityTableView.type = CommodityWithoutShelfTableView;
            [self.commodityTableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].noShelfCommodityDataArray];
        }
        else{
            
            [self.view addSubview:self.noDataView];
        }
    }
    
    [self.commodityTableView reloadData];
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

-(UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 50)];
        
        UISegmentedControl * control = [[UISegmentedControl alloc] initWithItems:@[@"有保质期",@"无保质期"]];
        control.selectedSegmentIndex = 0;
        control.frame = CGRectMake((SCREENWIDTH - 200) / 2, 2, 200, 46);
        [control addTarget:self action:@selector(controlClicked:) forControlEvents:UIControlEventValueChanged];
        [_headerView addSubview:control];
    }
    return _headerView;
}

-(SHPlainTableView *)commodityTableView{
    
    if (!_commodityTableView) {
        
        _commodityTableView = [[SHPlainTableView alloc] initWithFrame:CGRectMake(0, 114, SCREENWIDTH, SCREENHEIGHT - 104) andType:CommodityWithShelfTableView];
    }
    return _commodityTableView;
}

@end
