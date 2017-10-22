//
//  CategoryTableViewCell.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  类别cell

#import "TableViewCellWithBottomLine.h"
#import "CategoryModel.h"


@interface CategoryTableViewCell : TableViewCellWithBottomLine
@property (nonatomic,strong) CategoryModel * categoryModel;
@end
