//
//  CommodityTableViewCell.h
//  Home
//
//  Created by xianjunwang on 2017/10/23.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  物品cell

#import "TableViewCellWithBottomLine.h"

@class CommodityModel;

@interface CommodityTableViewCell : TableViewCellWithBottomLine
//物品模型
@property (nonatomic,strong) CommodityModel * commodityModel;
@end
