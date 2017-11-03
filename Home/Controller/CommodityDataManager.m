//
//  CommodityDataManager.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityDataManager.h"

@implementation CommodityDataManager


#pragma mark  ----  生命周期函数
//初始化方法
+(CommodityDataManager *)sharedManager{
    
    static CommodityDataManager * dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[CommodityDataManager alloc] init];
    });
    return dataManager;
}


#pragma mark  ----  懒加载
-(NSMutableArray<CommodityModel *> *)commodityDataArray{
    
    if (!_commodityDataArray) {
        
        _commodityDataArray = [[NSMutableArray alloc] init];
    }
    return _commodityDataArray;
}

-(NSMutableArray<PersonalRightsModel *> *)personalRightsArray{
    
    if (!_personalRightsArray) {
        
        _personalRightsArray = [[NSMutableArray alloc] init];
    }
    return _personalRightsArray;
}

@end
