//
//  CustomizedNavigationBar.m
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CustomizedNavigationBar.h"



@implementation CustomizedNavigationBar

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark  ----  自定义函数
//返回按钮的响应
-(void)backBtnClicked:(UIButton *)btn{
    
    
}


#pragma mark  ----  懒加载
-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, SCREENWIDTH - 160, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
