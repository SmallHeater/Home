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
-(NSMutableArray<CommodityModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
