//
//  CommodityDataManager.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  物品数据管理器

#import "BaseController.h"


@class CommodityModel,PersonalRightsModel;
@interface CommodityDataManager : BaseController

//物品列表数组
@property (nonatomic,strong) NSMutableArray<CommodityModel *> * commodityDataArray;
//权益列表数组
@property (nonatomic,strong) NSMutableArray<PersonalRightsModel *> * personalRightsArray;



//初始化方法
+(CommodityDataManager *)sharedManager;

@end
