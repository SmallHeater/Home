//
//  SHTableView.h
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  tableView

#import "BaseView.h"


typedef NS_ENUM(NSInteger, SHUITableViewType) {
    
    CommodityWithShelfTableView,//有物品保质期的物品列表
    CommodityWithoutShelfTableView,//无物品保质期的物品列表
    PersonalRightsTableView,//个人权益
    CategoryTableView//品类选择
};

@interface SHPlainTableView : BaseView
@property (nonatomic,assign) SHUITableViewType type;
@property (nonatomic,strong) NSMutableArray * dataArray;

-(instancetype)initWithFrame:(CGRect)frame andType:(SHUITableViewType) type;
-(void)reloadData;
@end
