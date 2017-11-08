//
//  PersonalRightsDetailViewController.h
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  个人权益详情页

#import "BaseNavViewController.h"

@class PersonalRightsModel;

@interface PersonalRightsDetailViewController : BaseNavViewController
//权益名
@property (nonatomic,strong) PersonalRightsModel * model;
@end
