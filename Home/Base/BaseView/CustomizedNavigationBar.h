//
//  CustomizedNavigationBar.h
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  自定义导航条

#import "BaseView.h"

@interface CustomizedNavigationBar : BaseView
//返回按钮
@property (nonatomic,strong) UIButton * backBtn;
//标题label
@property (nonatomic,strong) UILabel * titleLabel;
@end
