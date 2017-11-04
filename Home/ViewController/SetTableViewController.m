//
//  SetTableViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SetTableViewController.h"
#import "TableViewCellWithSwitch.h"
#import "ModelWithState.h"

@interface SetTableViewController ()

@end

@implementation SetTableViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.titleLabel.text = @"设置";
    self.navigationBar.backBtn.hidden = YES;
    self.view.backgroundColor = [UIColor grayColor];
    
    //指纹锁模型
    ModelWithState * fingerprintModel = [[ModelWithState alloc] init];
    fingerprintModel.title = @"开启指纹锁";
    fingerprintModel.switchState = YES;
    [self.dataArray addObject:fingerprintModel];
    
    //推送模型
    ModelWithState * pushModel = [[ModelWithState alloc] init];
    pushModel.title = @"开启物品到期提醒";
    pushModel.switchState = YES;
    [self.dataArray addObject:pushModel];
    
    //提建议
    ModelWithTitle * suggestionsModel = [[ModelWithTitle alloc] init];
    suggestionsModel.title = @"提建议";
    [self.dataArray addObject:suggestionsModel];
    
    //评价
    ModelWithTitle * commentModel = [[ModelWithTitle alloc] init];
    commentModel.title = @"去评价";
    [self.dataArray addObject:commentModel];
    
    //打赏一元
    ModelWithTitle * rewardModel = [[ModelWithTitle alloc] init];
    rewardModel.title = @"打赏一元";
    [self.dataArray addObject:rewardModel];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"设置页面"];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"设置页面"];
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
    
    if (indexPath.row < 2) {
        
        TableViewCellWithSwitch * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellWithSwitch"];
        if (!cell) {
            
            cell = [[TableViewCellWithSwitch alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCellWithSwitch"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        ModelWithState * model = self.dataArray[indexPath.row];
        cell.modelWithState = model;
        
        return cell;
    }
    else{
        
        TableViewCellWithTitle * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellWithTitle"];
        if (!cell) {
            
            cell = [[TableViewCellWithTitle alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCellWithTitle"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.modelWithTitle = self.dataArray[indexPath.row];
        
        return cell;
    }
    return nil;
}

#pragma mark  ----  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}
@end
