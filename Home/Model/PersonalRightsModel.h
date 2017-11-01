//
//  QuanyiModel.h
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  个人权益模型 

#import "BaseModel.h"

@interface PersonalRightsModel : BaseModel
//权益ID
@property (nonatomic,strong) NSString * personalRightsID;
//权益名称
@property (nonatomic,strong) NSString * personalRightsName;
//开始时间
@property (nonatomic,strong) NSString * personalRightsStartTime;
//结束时间
@property (nonatomic,strong) NSString * personalRightsEndTime;
//权益来源
@property (nonatomic,strong) NSString * personalRightsFrom;
//使用条件
@property (nonatomic,strong) NSString * personalRightsUsedConditions;
//享受条件
@property (nonatomic,strong) NSString * personalRightsEnjoyConditions;
//照片记录
@property (nonatomic,strong) NSMutableArray * personalRightsArray;
@end
