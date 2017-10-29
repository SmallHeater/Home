//
//  SHFMDBManager.m
//  Home
//
//  Created by xianjunwang on 2017/10/29.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SHFMDBManager.h"
#import "FMDB.h"
#import "CommodityModel.h"


@interface SHFMDBManager ()
@property (nonatomic,strong) FMDatabase * db;
@end

@implementation SHFMDBManager

#pragma mark  ----  生命周期函数
+(SHFMDBManager *)sharedManager{
    
    static SHFMDBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SHFMDBManager alloc] init];
        //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
        if ([manager.db open])
        {
            //4.创表（CommodityImageArray，CommodityLocationImageArray，存储前，数组归档(NSKeyedArchiver)为二进制数据，再存入数据库；从数据库取出时肯定也是取出的二进制数据，这时要将二进制数据解档（NSKeyedUnArchiver）为数组）
            BOOL result = [manager.db executeUpdate:@"CREATE TABLE IF NOT EXISTS Home_CommodityTable (CommodityID text NOT NULL,CommodityName text NOT NULL,CommodityImageArray text NOT NULL,CategoryID text NOT NULL,CategoryName text NOT NULL,CommodityLocation text NOT NULL,CommodityLocationImageArray text NOT NULL,hasShelfLife BOOL,shelfLife text);"];
            if (result)
            {
                NSLog(@"创建表成功");
            }
        }
    });
    return manager;
}

#pragma mark  ----  自定义方法
-(BOOL)insertCommodityModel:(CommodityModel *)model{
    
    NSData * commodityImageArrayData = [NSJSONSerialization dataWithJSONObject:model.commodityImageArray options:NSJSONWritingPrettyPrinted error:nil];
    NSData * commodityLocationImageArrayData = [NSJSONSerialization dataWithJSONObject:model.commodityLocationImagesArray options:NSJSONWritingPrettyPrinted error:nil];
    
    BOOL result = [self.db executeUpdate:@"INSERT INTO Home_CommodityTable (CommodityID,CommodityName,CommodityImageArray,CategoryID,CategoryName,CommodityLocation,CommodityLocationImageArray,hasShelfLife,shelfLife) VALUES (?,?,?,?,?,?,?,?,?)",model.commodityID,model.commodityName,commodityImageArrayData,model.categoryID,model.category,model.commodityLocation,commodityLocationImageArrayData,model.hasShelfLife,model.shelfLife];
    if (result) {
        
        NSLog(@"成功");
    }
    else{
        
        NSLog(@"失败");
    }
    return result;
}

#pragma mark  ----  懒加载
-(FMDatabase *)db{
    
    if (!_db) {
        
        //1.获得数据库文件的路径
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"Home.sqlite"];
        NSLog(@"数据库路径:%@",fileName);
        //2.获得数据库
        _db = [FMDatabase databaseWithPath:fileName];
    }
    return _db;
}

@end
