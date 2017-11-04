//
//  PersonalRightsCell.h
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  个人权益Cell,高度 60.5

#import "TableViewCellWithBottomLine.h"

@interface PersonalRightsCell : TableViewCellWithBottomLine
//权益名称
@property (nonatomic,strong) UILabel * personalRightsNameLabel;
//起止时间
@property (nonatomic,strong) UILabel * startEndTimeLabel;
//权益来源
@property (nonatomic,strong) UILabel * personalRightsFromLabel;
@end
