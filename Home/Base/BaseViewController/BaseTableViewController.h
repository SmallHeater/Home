//
//  BaseTableViewController.h
//  Home
//
//  Created by xianjunwang on 2017/10/21.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  带导航和表格的基类

#import "BaseNavViewController.h"

@interface BaseTableViewController : BaseNavViewController
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UITableView * tableView;
@end
