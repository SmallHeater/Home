//
//  SHFMDBManager.h
//  Home
//
//  Created by xianjunwang on 2017/10/29.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  二次封装的FMDB

#import <Foundation/Foundation.h>

@class CommodityModel;

@interface SHFMDBManager : NSObject
+(SHFMDBManager *)sharedManager;


-(BOOL)insertCommodityModel:(CommodityModel *)model;
@end
