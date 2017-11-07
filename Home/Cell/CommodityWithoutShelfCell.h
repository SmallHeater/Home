//
//  CommodityTableViewCell.h
//  Home
//
//  Created by xianjunwang on 2017/10/23.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  物品cell

#import "TableViewCellWithBottomLine.h"

#define LABELHEIGHT 20

@class CommodityModel;

@interface CommodityWithoutShelfCell : TableViewCellWithBottomLine
//物品模型
@property (nonatomic,strong) CommodityModel * commodityModel;


//物品图片
@property (nonatomic,strong) UIImageView * commodityImageView;
//物品数量
@property (nonatomic,strong) UILabel * commodityCountLabel;
@end
