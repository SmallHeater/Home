//
//  CategoryModel.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  品类模型

#import "BaseModel.h"

@interface CategoryModel : BaseModel
//品类名
@property (nonatomic,strong) NSString * categoryName;
//品类ID
@property (nonatomic,strong) NSString * categoryID;
@end
