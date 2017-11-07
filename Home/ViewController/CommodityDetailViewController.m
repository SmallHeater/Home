//
//  CommodityDetailViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityDetailViewController.h"

#define LABELHEIGHT 20

@interface CommodityDetailViewController ()

//物品图片轮播区
@property (nonatomic,strong) UIScrollView * commodityImageScrollView;
//物品名称title
@property (nonatomic,strong) UILabel * commodityNameTitleLabel;
//物品名称
@property (nonatomic,strong) UILabel * commodityNameLabel;
//位置title
@property (nonatomic,strong) UILabel * locationTitleLabel;
//位置
@property (nonatomic,strong) UILabel * locationLabel;
//位置图片轮播区
@property (nonatomic,strong) UIScrollView * locationImagesScrollView;
//品类title
@property (nonatomic,strong) UILabel * categoryTitleLabel;
//品类
@property (nonatomic,strong) UILabel * categoryLabel;
//到期时间title
@property (nonatomic,strong) UILabel * shelfTimeTitleLabel;
//到期时间
@property (nonatomic,strong) UILabel * shelfTimeLabel;
@end

@implementation CommodityDetailViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"物品详情";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载
-(UIScrollView *)commodityImageScrollView{
    
    if (!_commodityImageScrollView) {
        
        _commodityImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 200)];
    }
    return _commodityImageScrollView;
}

-(UILabel *)commodityNameTitleLabel{
    
    if (!_commodityNameTitleLabel) {
        
        NSString * str = @"物品名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _commodityNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageScrollView.frame), width, LABELHEIGHT)];
        _commodityNameTitleLabel.font = BOLDFONT14;
    }
    return _commodityNameTitleLabel;
}

-(UILabel *)commodityNameLabel{
    
    if (!_commodityNameLabel) {
        
        _commodityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityNameTitleLabel.frame), CGRectGetMinY(self.commodityNameTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.commodityNameTitleLabel.frame), LABELHEIGHT)];
        _commodityNameLabel.font = FONT14;
    }
    return _commodityNameLabel;
}

-(UILabel *)locationTitleLabel{
    
    if (!_locationTitleLabel) {
        
        NSString * str = @"物品位置：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _locationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityNameTitleLabel.frame), width, LABELHEIGHT)];
        _locationTitleLabel.font = BOLDFONT14;
    }
    return _locationTitleLabel;
}

-(UILabel *)locationLabel{
    
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.locationTitleLabel.frame), CGRectGetMinY(self.locationTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.locationTitleLabel.frame), LABELHEIGHT)];
        _locationLabel.font = FONT14;
    }
    return _locationLabel;
}

@end
