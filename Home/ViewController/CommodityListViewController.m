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

#import "PersonalRightsRewardingViewController.h"
@interface CommodityListViewController ()
//录入按钮
@property (nonatomic,strong) UIButton * rewardBtn;

@property (nonatomic,strong) SHPlainTableView * tableView;
@end

@implementation CommodityListViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.titleLabel.text = @"物品列表";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar addSubview:self.rewardBtn];
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"物品清单页面"];
    
    
    if ([CommodityDataManager sharedManager].dataArray.count == 0) {
        
        NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selecTable];
        [[CommodityDataManager sharedManager].dataArray addObjectsFromArray:dataArray];
        [self.tableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].dataArray];
    }
    else{
        
        [self.tableView.dataArray addObjectsFromArray:[CommodityDataManager sharedManager].dataArray];
    }
    [self.tableView reloadData];
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
    
//    CategorySelectViewController * categorySelectVC = [[CategorySelectViewController alloc] init];
//    [self.navigationController pushViewController:categorySelectVC animated:YES];
    
//    LogInViewController * loginVC = [[LogInViewController alloc] init];
//    [self.navigationController pushViewController:loginVC animated:YES];
    
    PersonalRightsRewardingViewController * vc = [[PersonalRightsRewardingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
        
        _tableView = [[SHPlainTableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) andType:CommodityTableView];
    }
    return _tableView;
}
@end
