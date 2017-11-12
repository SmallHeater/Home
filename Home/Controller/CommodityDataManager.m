//
//  CommodityDataManager.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityDataManager.h"
#import "SHFMDBManager.h"
#import "CommodityModel.h"

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
-(NSMutableArray<CommodityModel *> *)hasShelfCommodityDataArray{
    
    if (!_hasShelfCommodityDataArray) {
        
        _hasShelfCommodityDataArray = [[NSMutableArray alloc] init];
        NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selectCommodityTable];
        for (NSUInteger i = 0 ; i < dataArray.count; i++) {
            
            CommodityModel * model = dataArray[i];
            if (model.hasShelfLife) {
                
                [_hasShelfCommodityDataArray addObject:model];
            }
        }
        
    }
    return _hasShelfCommodityDataArray;
}

-(NSMutableArray<CommodityModel *> *)noShelfCommodityDataArray{
    
    if (!_noShelfCommodityDataArray) {
        
        _noShelfCommodityDataArray = [[NSMutableArray alloc] init];
        NSMutableArray * dataArray = [[SHFMDBManager sharedManager] selectCommodityTable];
        for (NSUInteger i = 0 ; i < dataArray.count; i++) {
            
            CommodityModel * model = dataArray[i];
            if (!model.hasShelfLife){
                
                [_noShelfCommodityDataArray addObject:model];
            }
        }
    }
    return _noShelfCommodityDataArray;
}

-(NSMutableArray<PersonalRightsModel *> *)personalRightsArray{
    
    if (!_personalRightsArray) {
        
        _personalRightsArray = [[NSMutableArray alloc] init];
    }
    return _personalRightsArray;
}

@end
