//
//  PersonalRightsDetailViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsDetailViewController.h"

@interface PersonalRightsDetailViewController ()

@end

@implementation PersonalRightsDetailViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * titleStr;
    if (self.personalRightsName && self.personalRightsName.length > 0) {
        
        titleStr = [[NSString alloc] initWithFormat:@"%@详情",self.personalRightsName];
    }
    else{
        
        titleStr = @"个人权益详情";
    }
    self.navigationBar.titleLabel.text = titleStr;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载

@end
