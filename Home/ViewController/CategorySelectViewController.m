//
//  CategorySelectViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CategorySelectViewController.h"
#import "CategoryModel.h"
#import "SHPlainTableView.h"

@interface CategorySelectViewController ()
@property (nonatomic,strong) NSArray * categoryNameArray;
@property (nonatomic,strong) SHPlainTableView * tableView;
@end

@implementation CategorySelectViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.titleLabel.text = @"选择品类";
    
    for (NSUInteger i = 0; i < self.categoryNameArray.count; i++) {
        
        CategoryModel * model = [[CategoryModel alloc] init];
        model.categoryName = self.categoryNameArray[i];
        [self.tableView.dataArray addObject:model];
    }
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"品类选择页面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"品类选择页面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载
-(NSArray *)categoryNameArray{

    if (!_categoryNameArray) {
        
        _categoryNameArray = [[NSMutableArray alloc] initWithObjects:@"衣服",@"鞋",@"包",@"美妆",@"钟表",@"手机",@"数码",@"电脑",@"办公用品",@"家用电器",@"食品",@"生鲜",@"酒水",@"玩具",@"乐器",@"汽车用品",@"家居厨具",@"礼品",@"邮币",@"工具", nil];
    }
    return _categoryNameArray;
}

-(SHPlainTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHPlainTableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) andType:CategoryTableView];
    }
    return _tableView;
}

@end
