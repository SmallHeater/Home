//
//  TableViewCellWithSwitch.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  左侧有标题，右侧有switch开关的cell

#import "TableViewCellWithTitle.h"
#import "ModelWithState.h"


@interface TableViewCellWithSwitch : TableViewCellWithTitle


//数据
@property (nonatomic,strong) ModelWithState * modelWithState;
@end
