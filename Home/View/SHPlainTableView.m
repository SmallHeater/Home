//
//  SHTableView.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SHPlainTableView.h"
#import "CommodityModel.h"
#import "CommodityTableViewCell.h"
#import "PersonalRightsModel.h"
#import "PersonalRightsCell.h"
#import "CategoryTableViewCell.h"
#import "CommodityRewardingViewController.h"


@interface SHPlainTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,assign) SHUITableViewType type;
@end


@implementation SHPlainTableView

#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame andType:(SHUITableViewType)type{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.type = type;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark  ----  代理函数
#pragma mark  ----  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.type) {
        case CommodityTableView:
            {
                CommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityTableViewCell"];
                if (!cell) {
                    
                    cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommodityTableViewCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.commodityModel = self.dataArray[indexPath.row];
                return cell;
            }
            break;
        case PersonalRightsTableView:
        {
            
            CommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityTableViewCell"];
            if (!cell) {
                
                cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommodityTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.commodityModel = self.dataArray[indexPath.row];
            return cell;
        }
        case CategoryTableView:
        {
            CategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
            if (!cell) {
                
                cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.categoryModel = self.dataArray[indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.type) {
        case CommodityTableView:
            return 120.5;
            break;
        case PersonalRightsTableView:
            return 100;
            break;
        case CategoryTableView:
            return 40;
            break;
        default:
            break;
    }
    return 120.5;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.type) {
        case CommodityTableView:
        {
        }
            break;
        case PersonalRightsTableView:
        {
        }
            break;
        case CategoryTableView:
        {
            CategoryModel * selectedModel = self.dataArray[indexPath.row];
            CommodityRewardingViewController * rewardingViewController = [[CommodityRewardingViewController alloc] init];
            rewardingViewController.categoryStr = selectedModel.categoryName;
            
            UIViewController * vc = [self viewController];
            
            if (vc) {
                
                [vc.navigationController pushViewController:rewardingViewController animated:YES];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark  ----  自定义函数
-(void)reloadData{
 
    [self.tableView reloadData];
}

/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



#pragma mark  ----  懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
