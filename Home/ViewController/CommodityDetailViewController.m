//
//  CommodityDetailViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityDetailViewController.h"

@interface CommodityDetailViewController ()

@end

@implementation CommodityDetailViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * titleStr;
    if (self.commodityName && self.commodityName.length > 0) {
        
        titleStr = [[NSString alloc] initWithFormat:@"%@详情",self.commodityName];
    }
    else{
        
        titleStr = @"物品详情";
    }
    self.navigationBar.titleLabel.text = titleStr;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载


@end
