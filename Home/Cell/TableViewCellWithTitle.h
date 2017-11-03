//
//  TableViewCellWithTitle.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  只有左侧标题和底部分割线的cell,高40

#import "TableViewCellWithBottomLine.h"
#import "ModelWithTitle.h"


@interface TableViewCellWithTitle : TableViewCellWithBottomLine

//左侧标题
@property (nonatomic,strong) UILabel * titleLabel;

//数据
@property (nonatomic,strong) ModelWithTitle * modelWithTitle;
@end
