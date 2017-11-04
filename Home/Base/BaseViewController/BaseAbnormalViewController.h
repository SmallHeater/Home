//
//  BaseAbnormalViewController.h
//  Home
//
//  Created by xianjunwang on 2017/11/4.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  带有无网络，无数据等异常view的页面

#import "BaseNavViewController.h"
#import "NoDataView.h"



@interface BaseAbnormalViewController : BaseNavViewController
//无数据
@property (nonatomic,strong) NoDataView * noDataView;
//无网络
@end
