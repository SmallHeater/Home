//
//  BaseNavViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "BaseNavViewController.h"

@implementation BaseNavViewController

#pragma mark  ----  生命周期函数
-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view addSubview:self.navigationBar];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //隐藏系统默认导航条
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark  ----  懒加载
-(CustomizedNavigationBar *)navigationBar{
    
    if (!_navigationBar) {
        
        _navigationBar = [[CustomizedNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    }
    return _navigationBar;
}

@end
