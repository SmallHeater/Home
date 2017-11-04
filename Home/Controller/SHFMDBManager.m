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
#import "PersonalRightsModel.h"

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
            BOOL commodityResult = [manager.db executeUpdate:@"CREATE TABLE IF NOT EXISTS Home_CommodityTable (CommodityID text NOT NULL,CommodityName text NOT NULL,CommodityImageArray blob NOT NULL,CommodityCount integer,CategoryID text NOT NULL,CategoryName text NOT NULL,CommodityLocation text NOT NULL,CommodityLocationImageArray blob NOT NULL,hasShelfLife integer,shelfLife text);"];
            if (commodityResult)
            {
                NSLog(@"创建物品表成功");
            }
            
            
            BOOL personalRightsResult = [manager.db executeUpdate:@"CREATE TABLE IF NOT EXISTS Home_PersonalRightsTable (PersonalRightsID text NOT NULL,PersonalRightsName text NOT NULL,PersonalRightsStartTime text NOT NULL,PersonalRightsEndTime text NOT NULL,PersonalRightsFrom text NOT NULL,PersonalRightsUsedConditions text NOT NULL,PersonalRightsEnjoyConditions text NOT NULL,PersonalRightsArray blob NOT NULL);"];
            if (personalRightsResult)
            {
                NSLog(@"创建权益表成功");
            }
            
            [manager.db close];
        }
    });
    return manager;
}

#pragma mark  ----  自定义方法
//增
-(BOOL)insertModel:(BaseModel *)model{
    
    BOOL result = NO;
    if ([self.db open]) {
        
        if ([model isKindOfClass:[CommodityModel class]]) {
            
            CommodityModel * commodityModel = (CommodityModel *)model;
            NSData * commodityImageArrayData = [NSKeyedArchiver archivedDataWithRootObject:commodityModel.commodityImageArray];
            NSData * commodityLocationImageArrayData = [NSKeyedArchiver archivedDataWithRootObject:commodityModel.commodityLocationImagesArray];
            
            NSString * sql = [[NSString alloc] initWithFormat:@"INSERT INTO Home_CommodityTable(CommodityID,CommodityName,CommodityImageArray,CommodityCount,CategoryID,CategoryName,CommodityLocation,CommodityLocationImageArray,hasShelfLife,shelfLife) VALUES (?,?,?,?,?,?,?,?,?,?)"];
            
            result = [self.db executeUpdate:sql,commodityModel.commodityID,commodityModel.commodityName,commodityImageArrayData,[NSNumber numberWithUnsignedInteger:commodityModel.commodityCount],commodityModel.categoryID,commodityModel.category,commodityModel.commodityLocation,commodityLocationImageArrayData,[NSNumber numberWithBool:commodityModel.hasShelfLife],commodityModel.shelfLife];
            if (result) {
                
                NSLog(@"成功");
            }
            else{
                
                NSLog(@"失败");
            }
        }
        else if ([model isKindOfClass:[PersonalRightsModel class]]){
            
            PersonalRightsModel * personalRightsModel = (PersonalRightsModel *)model;
            NSData * personalRightsPhotoData = [NSKeyedArchiver archivedDataWithRootObject:personalRightsModel.personalRightsPhotoArray];
            
            
            NSString * sql = [[NSString alloc] initWithFormat:@"INSERT INTO Home_PersonalRightsTable(PersonalRightsID,PersonalRightsName,PersonalRightsStartTime,PersonalRightsEndTime,PersonalRightsFrom,PersonalRightsUsedConditions,PersonalRightsEnjoyConditions,PersonalRightsArray) VALUES (?,?,?,?,?,?,?,?)"];
            
            result = [self.db executeUpdate:sql,personalRightsModel.personalRightsID,personalRightsModel.personalRightsName,personalRightsModel.personalRightsStartTime,personalRightsModel.personalRightsEndTime,personalRightsModel.personalRightsFrom,personalRightsModel.personalRightsUsedConditions,personalRightsModel.personalRightsEnjoyConditions,personalRightsPhotoData];
            if (result) {
                
                NSLog(@"成功");
            }
            else{
                
                NSLog(@"失败");
            }
        }
    }
    //关闭数据库
    [self.db close];
    
    return result;
}

//删
-(BOOL)deleteCommodityModel:(CommodityModel *)model{
    
    BOOL result = NO;
    if ([self.db open]) {
        
        if ([model isKindOfClass:[CommodityModel class]]) {
            
            CommodityModel * commodityModel = (CommodityModel *)model;
            NSString * sql = [[NSString alloc] initWithFormat:@"delete from Home_CommodityTable where CommodityID = '%@'",commodityModel.commodityID];
            result = [self.db executeUpdate:sql];
            if (result) {
                
                NSLog(@"成功");
            }
            else{
                
                NSLog(@"失败");
            }
        }
        else if ([model isKindOfClass:[PersonalRightsModel class]]){
            
            PersonalRightsModel * personalRightsModel = (PersonalRightsModel *)model;
            result = [self.db executeUpdate:@"delete from Home_PersonalRightsTable where PersonalRightsID = '%@'",personalRightsModel.personalRightsID];
            if (result) {
                
                NSLog(@"成功");
            }
            else{
                
                NSLog(@"失败");
            }
        }
    }
    //关闭数据库
    [self.db close];
    
    return result;
}

//改
-(BOOL)updateCommodityModel:(CommodityModel *)model{
    
    BOOL result = NO;
    if ([self.db open]) {
        
        NSData * commodityImageArrayData = [NSJSONSerialization dataWithJSONObject:model.commodityImageArray options:NSJSONWritingPrettyPrinted error:nil];
        NSData * commodityLocationImageArrayData = [NSJSONSerialization dataWithJSONObject:model.commodityLocationImagesArray options:NSJSONWritingPrettyPrinted error:nil];
        
        result = [self.db executeUpdate:@"UPDATE Home_CommodityTable set CommodityName = '%@', CommodityImageArray = '%@', CategoryID = '%@', CategoryName = '%@', CommodityLocation = '%@', CommodityLocationImageArray = '%@', hasShelfLife = '%d', shelfLife = '%@' where CommodityID = '%@'",model.commodityName,commodityImageArrayData,model.categoryID,model.category,model.commodityLocation,commodityLocationImageArrayData,model.hasShelfLife,@"rr",model.commodityID];
        if (result) {
            
            NSLog(@"成功");
        }
        else{
            
            NSLog(@"失败");
        }
    }
    //关闭数据库
    [self.db close];
    
    return result;
}

//查
-(NSMutableArray<CommodityModel *> *)selectCommodityTable{

    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    if ([self.db open]) {
        //创建sql语句
        NSString *sql = @"select * from Home_CommodityTable";
        //执行查询
        FMResultSet *set = [self.db executeQuery:sql];
        while ([set next]) {
            //创建对象
            CommodityModel * model = [[CommodityModel alloc]init];
            model.commodityID = [set stringForColumn:@"commodityID"];
            model.category = [set stringForColumn:@"CategoryName"];
            model.categoryID = [set stringForColumn:@"categoryID"];
            model.commodityName = [set stringForColumn:@"commodityName"];
            model.commodityCount = [set intForColumn:@"commodityCount"];
            NSData * commodityImageArrayData = [set dataForColumn:@"commodityImageArray"];
            
            NSMutableArray * commodityImageArray = [NSKeyedUnarchiver unarchiveObjectWithData:commodityImageArrayData];
            model.commodityImageArray = commodityImageArray;
            model.commodityLocation = [set stringForColumn:@"commodityLocation"];
            
            NSData * commodityLocationImagesArrayData = [set dataForColumn:@"CommodityLocationImageArray"];
            NSMutableArray * commodityLocationImagesArray = [NSKeyedUnarchiver unarchiveObjectWithData:commodityLocationImagesArrayData];
            model.commodityLocationImagesArray = commodityLocationImagesArray;
            model.hasShelfLife = [set boolForColumn:@"hasShelfLife"];
            model.shelfLife = [set stringForColumn:@"shelfLife"];
            //加入数组
            [dataArray addObject:model];
        }
    }else{
        NSLog(@"打开数据库失败！");
    }
    //关闭数据库
    [self.db close];
    
    return dataArray;
}

-(NSMutableArray<PersonalRightsModel *> *)selectPersonalRightsTable{

    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    if ([self.db open]) {
        //创建sql语句
        NSString *sql = @"select * from Home_PersonalRightsTable";
        //执行查询
        FMResultSet *set = [self.db executeQuery:sql];
        while ([set next]) {
            //创建对象
            PersonalRightsModel * model = [[PersonalRightsModel alloc]init];
            model.personalRightsID = [set stringForColumn:@"personalRightsID"];
            model.personalRightsName = [set stringForColumn:@"personalRightsName"];
            model.personalRightsStartTime = [set stringForColumn:@"personalRightsStartTime"];
            model.personalRightsEndTime = [set stringForColumn:@"personalRightsEndTime"];
            model.personalRightsFrom = [set stringForColumn:@"personalRightsFrom"];
            model.personalRightsUsedConditions = [set stringForColumn:@"personalRightsUsedConditions"];
            model.personalRightsEnjoyConditions = [set stringForColumn:@"personalRightsEnjoyConditions"];
            
            NSData * personalRightsPhotoArrayData = [set dataForColumn:@"personalRightsPhotoArray"];
            
            NSMutableArray * personalRightsPhotoArray = [NSKeyedUnarchiver unarchiveObjectWithData:personalRightsPhotoArrayData];
            model.personalRightsPhotoArray = personalRightsPhotoArray;
            //加入数组
            [dataArray addObject:model];
        }
    }else{
        NSLog(@"打开数据库失败！");
    }
    //关闭数据库
    [self.db close];
    
    return dataArray;
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
