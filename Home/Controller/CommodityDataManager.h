//
//  CommodityDataManager.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  物品数据管理器

#import "BaseController.h"


@class CommodityModel;
@interface CommodityDataManager : BaseController

@property (nonatomic,strong) NSMutableArray<CommodityModel *> * dataArray;


//初始化方法
+(CommodityDataManager *)sharedManager;

@end
