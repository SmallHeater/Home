//
//  CommodityModel.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel

#pragma mark  ----  懒加载

-(NSMutableArray *)commodityImageArray{
    
    if (!_commodityImageArray) {
        
        _commodityImageArray = [[NSMutableArray alloc] init];
    }
    return _commodityImageArray;
}

-(NSMutableArray *)commodityLocationImagesArray{
    
    if (!_commodityLocationImagesArray) {
        
        _commodityLocationImagesArray = [[NSMutableArray alloc] init];
    }
    return _commodityLocationImagesArray;
}

@end
