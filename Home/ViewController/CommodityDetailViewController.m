//
//  CommodityDetailViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CommodityModel.h"


#define LABELHEIGHT 20
#define SCROLLVIEWHEIGHT 150

@interface CommodityDetailViewController ()<UIScrollViewDelegate>

//物品图片轮播区
@property (nonatomic,strong) UIScrollView * commodityImageScrollView;
//物品图片区域小白点
@property (nonatomic,strong) UIPageControl * commodityImagePageControl;
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
//位置图片区域小白点
@property (nonatomic,strong) UIPageControl * locationImagesPageControl;
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
    
    [self.view addSubview:self.commodityImageScrollView];
    [self.view addSubview:self.commodityNameTitleLabel];
    [self.view addSubview:self.commodityNameLabel];
    [self.view addSubview:self.locationTitleLabel];
    [self.view addSubview:self.locationLabel];
    [self.view addSubview:self.locationImagesScrollView];
    [self.view addSubview:self.categoryTitleLabel];
    [self.view addSubview:self.categoryLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    
    if ([scrollView isEqual:self.commodityImageScrollView]) {
        
        self.commodityImagePageControl.currentPage = index;
    }
    else if ([scrollView isEqual:self.locationImagesScrollView]){
        
        self.locationImagesPageControl.currentPage = index;
    }
}


#pragma mark  ----  SET
-(void)setModel:(CommodityModel *)model{
    
    _model = model;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    for (NSUInteger i = 0; i < self.model.commodityImageArray.count; i++) {
        
        NSString *imageFilePath = [path stringByAppendingPathComponent:self.model.commodityImageArray[i]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
        imageView.frame = CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCROLLVIEWHEIGHT);
        [self.commodityImageScrollView addSubview:imageView];
        
        if (i == self.model.commodityImageArray.count - 1) {
            
            self.commodityImageScrollView.contentSize = CGSizeMake(SCREENWIDTH * self.model.commodityImageArray.count, SCROLLVIEWHEIGHT);
            
            self.commodityImagePageControl.numberOfPages = self.model.commodityImageArray.count;
            [self.view addSubview:self.commodityImagePageControl];
        }
    }
    
    self.commodityNameLabel.text = self.model.commodityName;
    self.locationLabel.text = self.model.commodityLocation;
    
    for (NSUInteger i = 0; i < self.model.commodityLocationImagesArray.count; i++) {
        
        NSString *imageFilePath = [path stringByAppendingPathComponent:self.model.commodityLocationImagesArray[i]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
        imageView.frame = CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCROLLVIEWHEIGHT);
        [self.locationImagesScrollView addSubview:imageView];
        
        if (i == self.model.commodityLocationImagesArray.count - 1) {
            
            self.locationImagesScrollView.contentSize = CGSizeMake(SCREENWIDTH * self.model.commodityLocationImagesArray.count, SCROLLVIEWHEIGHT);
            
            self.locationImagesPageControl.numberOfPages = self.model.commodityLocationImagesArray.count;
            [self.view addSubview:self.locationImagesPageControl];
        }
    }
    
    self.categoryLabel.text = self.model.category;
    if (self.model.hasShelfLife) {
        
        self.shelfTimeLabel.text = self.model.shelfLife;
        [self.view addSubview:self.shelfTimeTitleLabel];
        [self.view addSubview:self.shelfTimeLabel];
    }
}

#pragma mark  ----  懒加载
-(UIScrollView *)commodityImageScrollView{
    
    if (!_commodityImageScrollView) {
        
        _commodityImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCROLLVIEWHEIGHT)];
        _commodityImageScrollView.contentSize = CGSizeMake(SCREENWIDTH,SCROLLVIEWHEIGHT);
        _commodityImageScrollView.pagingEnabled = YES;
        _commodityImageScrollView.delegate = self;
    }
    return _commodityImageScrollView;
}

-(UIPageControl *)commodityImagePageControl{
    
    if (!_commodityImagePageControl) {
        
        _commodityImagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageScrollView.frame) - 20, SCREENWIDTH, 20)];
    }
    return _commodityImagePageControl;
}

-(UILabel *)commodityNameTitleLabel{
    
    if (!_commodityNameTitleLabel) {
        
        NSString * str = @"物品名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _commodityNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageScrollView.frame), width, LABELHEIGHT)];
        _commodityNameTitleLabel.font = BOLDFONT14;
        _commodityNameTitleLabel.text = str;
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
        _locationTitleLabel.text = str;
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

-(UIScrollView *)locationImagesScrollView{
    
    if (!_locationImagesScrollView) {
        
        _locationImagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.locationTitleLabel.frame), SCREENWIDTH, SCROLLVIEWHEIGHT)];
        _locationImagesScrollView.contentSize = CGSizeMake(SCREENWIDTH, SCROLLVIEWHEIGHT);
        _locationImagesScrollView.pagingEnabled = YES;
        _locationImagesScrollView.delegate = self;
    }
    return _locationImagesScrollView;
}

-(UIPageControl *)locationImagesPageControl{
    
    if (!_locationImagesPageControl) {
        
        _locationImagesPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.locationImagesScrollView.frame) - 20, SCREENWIDTH, 20)];
    }
    return _locationImagesPageControl;
}

-(UILabel *)categoryTitleLabel{
    
    if (!_categoryTitleLabel) {
        
        NSString * str = @"品类:";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _categoryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.locationImagesScrollView.frame), width, LABELHEIGHT)];
        _categoryTitleLabel.font = BOLDFONT14;
        _categoryTitleLabel.text = str;
    }
    return _categoryTitleLabel;
}

-(UILabel *)categoryLabel{
    
    if (!_categoryLabel) {
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.categoryTitleLabel.frame), CGRectGetMinY(self.categoryTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.categoryTitleLabel.frame), LABELHEIGHT)];
        _categoryLabel.font = FONT14;
    }
    return _categoryLabel;
}

-(UILabel *)shelfTimeTitleLabel{
    
    if (!_shelfTimeTitleLabel) {
        
        NSString * str = @"到期时间：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _shelfTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.categoryLabel.frame), width, LABELHEIGHT)];
        _shelfTimeTitleLabel.font = BOLDFONT14;
        _shelfTimeTitleLabel.text = str;
    }
    return _shelfTimeTitleLabel;
}

-(UILabel *)shelfTimeLabel{
    
    if (!_shelfTimeLabel) {
        
        _shelfTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shelfTimeTitleLabel.frame), CGRectGetMinY(self.shelfTimeTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.shelfTimeTitleLabel.frame), LABELHEIGHT)];
        _shelfTimeLabel.font = FONT14;
    }
    return _shelfTimeLabel;
}

@end
