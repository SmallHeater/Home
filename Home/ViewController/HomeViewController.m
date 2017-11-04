//
//  FirstViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "HomeViewController.h"
#import "CommodityListViewController.h"
#import "SearchViewController.h"
#import "PersonalRightsViewController.h"


#define BTNTAGBASE  1301


@interface HomeViewController ()
//物品列表
@property (nonatomic,strong) UIButton * commodityListBtn;
//每日必做
@property (nonatomic,strong) UIButton * doBtn;
//我的权益
@property (nonatomic,strong) UIButton * myBtn;
//未来目标
@property (nonatomic,strong) UIButton * willBtn;
//优惠记录
@property (nonatomic,strong) UIButton * rewardBtn;
@end

@implementation HomeViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleLabel.text = @"首页";
    self.navigationBar.backBtn.hidden = YES;
    
    [self.view addSubview:self.commodityListBtn];
    [self.view addSubview:self.doBtn];
    [self.view addSubview:self.myBtn];
    [self.view addSubview:self.willBtn];
    [self.view addSubview:self.rewardBtn];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  自定义函数
-(void)btnClicked:(UIButton *)btn{
    
    switch (btn.tag - BTNTAGBASE) {
        case 0:
        {
            CommodityListViewController * vc = [[CommodityListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
           
        }
            break;
        case 2:
        {
            PersonalRightsViewController * personalRightsViewController = [[PersonalRightsViewController alloc] init];
            [self.navigationController pushViewController:personalRightsViewController animated:YES];
        }
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

#pragma mark  ----  懒加载

-(UIButton *)commodityListBtn{
    
    if (!_commodityListBtn) {
        
        _commodityListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commodityListBtn.frame = CGRectMake(100, 160, 120, 44);
        _commodityListBtn.tag = BTNTAGBASE;
        [_commodityListBtn setTitle:@"物品列表" forState:UIControlStateNormal];
        [_commodityListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commodityListBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commodityListBtn;
}

-(UIButton *)doBtn{
    
    if (!_doBtn) {
        
        _doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doBtn.frame = CGRectMake(100, 210, 120, 44);
        _doBtn.tag = BTNTAGBASE + 1;
        [_doBtn setTitle:@"每日必做" forState:UIControlStateNormal];
        [_doBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_doBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doBtn;
}

-(UIButton *)myBtn{
    
    if (!_myBtn) {
        
        _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myBtn.frame = CGRectMake(100, 260, 120, 44);
        _myBtn.tag = BTNTAGBASE + 2;
        [_myBtn setTitle:@"我的权益" forState:UIControlStateNormal];
        [_myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myBtn;
}

-(UIButton *)willBtn{
    
    if (!_willBtn) {
        
        _willBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _willBtn.frame = CGRectMake(100, 310, 120, 44);
        _willBtn.tag = BTNTAGBASE + 3;
        [_willBtn setTitle:@"未来目标" forState:UIControlStateNormal];
        [_willBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_willBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _willBtn;
}

-(UIButton *)rewardBtn{
    
    if (!_rewardBtn) {
        
        _rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rewardBtn.frame = CGRectMake(100, 360, 120, 44);
        _rewardBtn.tag = BTNTAGBASE + 4;
        [_rewardBtn setTitle:@"优惠记录" forState:UIControlStateNormal];
        [_rewardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rewardBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewardBtn;
}
@end
