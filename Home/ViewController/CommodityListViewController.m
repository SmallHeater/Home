//
//  CommodityListViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityListViewController.h"
#import "CategorySelectViewController.h"


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
    
    [self.navigationBar addSubview:self.rewardBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark  ----  自定义函数
-(void)rewardBtnClicked:(UIButton *)btn{
    
    CategorySelectViewController * categorySelectVC = [[CategorySelectViewController alloc] init];
    [self.navigationController pushViewController:categorySelectVC animated:YES];
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
