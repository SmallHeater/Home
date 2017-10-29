//
//  LogInViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/29.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "LogInViewController.h"
#import <UMSocialCore/UMSocialCore.h>



@interface LogInViewController ()

@end

@implementation LogInViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"登录";
    
    
    NSArray * arr =@[@"新浪微博",@"qq",@"微信"];
    
    for (NSUInteger i = 0; i < 3; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i * 70, 100, 60, 40);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = 1120 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  自定义函数
-(void)btnClicked:(UIButton *)btn{
    
    if (btn.tag == 1120) {
        
        //新浪微博
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"Sina uid: %@", resp.uid);
                NSLog(@"Sina accessToken: %@", resp.accessToken);
                NSLog(@"Sina refreshToken: %@", resp.refreshToken);
                NSLog(@"Sina expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"Sina name: %@", resp.name);
                NSLog(@"Sina iconurl: %@", resp.iconurl);
                NSLog(@"Sina gender: %@", resp.unionGender);
                
                // 第三方平台SDK源数据
                NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            }
        }];
    }
    else if (btn.tag == 1121){
        
        //qq
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"QQ uid: %@", resp.uid);
                NSLog(@"QQ openid: %@", resp.openid);
                NSLog(@"QQ unionid: %@", resp.unionId);
                NSLog(@"QQ accessToken: %@", resp.accessToken);
                NSLog(@"QQ expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"QQ name: %@", resp.name);
                NSLog(@"QQ iconurl: %@", resp.iconurl);
                NSLog(@"QQ gender: %@", resp.unionGender);
                
                // 第三方平台SDK源数据
                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            }
        }];
    }
    else if (btn.tag == 1122){
        
        //微信
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"Wechat uid: %@", resp.uid);
                NSLog(@"Wechat openid: %@", resp.openid);
                NSLog(@"Wechat unionid: %@", resp.unionId);
                NSLog(@"Wechat accessToken: %@", resp.accessToken);
                NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                NSLog(@"Wechat expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"Wechat name: %@", resp.name);
                NSLog(@"Wechat iconurl: %@", resp.iconurl);
                NSLog(@"Wechat gender: %@", resp.unionGender);
                
                // 第三方平台SDK源数据
                NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            }
        }];
    }
}

#pragma mark  ----  懒加载

@end
