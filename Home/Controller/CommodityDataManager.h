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

//有保质期的物品列表数组
@property (nonatomic,strong) NSMutableArray<CommodityModel *> * hasShelfCommodityDataArray;
//无保质期的物品列表数组
@property (nonatomic,strong) NSMutableArray<CommodityModel *> * noShelfCommodityDataArray;

//权益列表数组
@property (nonatomic,strong) NSMutableArray<PersonalRightsModel *> * personalRightsArray;



//初始化方法
+(CommodityDataManager *)sharedManager;

@end
