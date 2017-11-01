//
//  QuanyiViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsViewController.h"
#import "SHPlainTableView.h"


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  自定义函数
-(void)rewardBtnClicked:(UIButton *)btn{
    
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
