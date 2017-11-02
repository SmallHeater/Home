//
//  SHFMDBManager.h
//  Home
//
//  Created by xianjunwang on 2017/10/29.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  二次封装的FMDB

#import <Foundation/Foundation.h>

@class BaseModel;

@interface SHFMDBManager : NSObject
+(SHFMDBManager *)sharedManager;

//增
-(BOOL)insertModel:(BaseModel *)model;
//删
-(BOOL)deleteCommodityModel:(BaseModel *)model;
//改
-(BOOL)updateCommodityModel:(BaseModel *)model;
//查
-(NSMutableArray<BaseModel *> *)selecTable;
@end
