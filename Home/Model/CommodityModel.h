//
//  CommodityModel.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  商品模型

#import "BaseModel.h"

@interface CommodityModel : BaseModel
//自己生成的唯一ID
@property (nonatomic,copy) NSString * commodityID;
//品类
@property (nonatomic,copy) NSString * category;
//品类ID
@property (nonatomic,copy) NSString * categoryID;
//物品名
@property (nonatomic,copy) NSString * commodityName;
//物品数量
@property (nonatomic,assign) NSUInteger commodityCount;
//物品图片数组
@property (nonatomic,strong) NSMutableArray * commodityImageArray;
//物品存放位置
@property (nonatomic,copy) NSString * commodityLocation;
//物品存放位置图片数组
@property (nonatomic,strong) NSMutableArray * commodityLocationImagesArray;
//有无保质期
@property (nonatomic,assign) BOOL hasShelfLife;
//保质期
@property (nonatomic,strong) NSString * shelfLife;
@end
