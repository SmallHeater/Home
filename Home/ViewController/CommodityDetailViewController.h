//
//  CommodityDetailViewController.h
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  物品详情页

#import "BaseNavViewController.h"

@class CommodityModel;

@interface CommodityDetailViewController : BaseNavViewController
//物品模型
@property (nonatomic,strong) CommodityModel * model;
@end
