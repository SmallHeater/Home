//
//  TableViewCellWithBottomLine.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  只有底部分割线的cell

#import "BaseTableViewCell.h"

@interface TableViewCellWithBottomLine : BaseTableViewCell

//底部分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;
@end
