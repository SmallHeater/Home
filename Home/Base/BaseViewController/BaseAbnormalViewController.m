//
//  BaseAbnormalViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/4.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "BaseAbnormalViewController.h"



@interface BaseAbnormalViewController ()

@end

@implementation BaseAbnormalViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载
-(NoDataView *)noDataView{
    
    if (!_noDataView) {
        
        _noDataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    }
    return _noDataView;
}

@end
