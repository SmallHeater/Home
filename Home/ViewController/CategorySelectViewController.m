//
//  CategorySelectViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CategorySelectViewController.h"
#import "CategoryTableViewCell.h"
#import "CategoryModel.h"
#import "RewardingViewController.h"


@interface CategorySelectViewController ()

@end

@implementation CategorySelectViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.titleLabel.text = @"选择品类";
    
    NSArray * categoryNameArray = [[NSArray alloc] initWithObjects:@"衣服",@"鞋",@"包",@"美妆",@"钟表",@"手机",@"数码",@"电脑",@"办公用品",@"家用电器",@"食品",@"生鲜",@"酒水",@"玩具",@"乐器",@"汽车用品",@"家居厨具",@"礼品",@"邮币",@"工具", nil];
    for (NSUInteger i = 0; i < categoryNameArray.count; i++) {
        
        CategoryModel * model = [[CategoryModel alloc] init];
        model.categoryName = categoryNameArray[i];
        [self.dataArray addObject:model];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"品类选择页面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"品类选择页面"];
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

    CategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    if (!cell) {
        
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.categoryModel = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark  ----  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryModel * selectedModel = self.dataArray[indexPath.row];
    RewardingViewController * rewardingViewController = [[RewardingViewController alloc] init];
    rewardingViewController.categoryStr = selectedModel.categoryName;
    [self.navigationController pushViewController:rewardingViewController animated:YES];
}



@end
