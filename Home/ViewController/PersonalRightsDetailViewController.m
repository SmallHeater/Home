//
//  PersonalRightsDetailViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsDetailViewController.h"
#import "PersonalRightsModel.h"

#define LABELHEIGHT 20
#define SCROLLVIEWHEIGHT 150


@interface PersonalRightsDetailViewController ()

//权益名称title
@property (nonatomic,strong) UILabel * personalRightsTitleLabel;
//权益名称
@property (nonatomic,strong) UILabel * personalRightsLabel;
//起止时间title
@property (nonatomic,strong) UILabel * startEndTimeTitleLabel;
//起止时间
@property (nonatomic,strong) UILabel * startEndTimeLabel;
//权益来源title
@property (nonatomic,strong) UILabel * personalRightsFromTitleLabel;
//权益来源
@property (nonatomic,strong) UILabel * personalRightsFromLabel;
//使用条件title
@property (nonatomic,strong) UILabel * useConditionTitleLabel;
//使用条件
@property (nonatomic,strong) UILabel * useConditionLabel;
//享受条件title
@property (nonatomic,strong) UILabel * enjoyConditionTitleLabel;
//享受条件
@property (nonatomic,strong) UILabel * enjoyConditionLabel;
//照片记录title
@property (nonatomic,strong) UILabel * photoRewardTitleLabel;
//照片记录ScrollView
@property (nonatomic,strong) UIScrollView * photoRewardScrollView;
//照片区域小白点
@property (nonatomic,strong) UIPageControl * photoPageControl;
@end

@implementation PersonalRightsDetailViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益详情";
    
    [self.view addSubview:self.personalRightsTitleLabel];
    [self.view addSubview:self.personalRightsLabel];
    [self.view addSubview:self.startEndTimeTitleLabel];
    [self.view addSubview:self.startEndTimeLabel];
    [self.view addSubview:self.personalRightsFromTitleLabel];
    [self.view addSubview:self.personalRightsFromLabel];
    [self.view addSubview:self.useConditionTitleLabel];
    [self.view addSubview:self.useConditionLabel];
    [self.view addSubview:self.enjoyConditionTitleLabel];
    [self.view addSubview:self.enjoyConditionLabel];
    [self.view addSubview:self.photoRewardTitleLabel];
    [self.view addSubview:self.photoRewardScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  SET
-(void)setModel:(PersonalRightsModel *)model{
    
    _model = model;
    self.personalRightsLabel.text = self.model.personalRightsName;
    self.startEndTimeLabel.text = [[NSString alloc] initWithFormat:@"%@到%@",self.model.personalRightsStartTime,self.model.personalRightsEndTime];
    self.personalRightsFromLabel.text = self.model.personalRightsFrom;
    self.useConditionLabel.text = self.model.personalRightsUsedConditions;
    self.enjoyConditionLabel.text = self.model.personalRightsEnjoyConditions;

    
    for (NSUInteger i = 0; i < self.model.personalRightsPhotoArray.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:self.model.personalRightsPhotoArray[i]]];
        imageView.frame = CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCROLLVIEWHEIGHT);
        [self.photoRewardScrollView addSubview:imageView];
        imageView.backgroundColor = [UIColor greenColor];
        
        if (i == self.model.personalRightsPhotoArray.count - 1) {
            
            self.photoRewardScrollView.contentSize = CGSizeMake(SCREENWIDTH * self.model.personalRightsPhotoArray.count, SCROLLVIEWHEIGHT);
            
            self.photoPageControl.numberOfPages = self.model.personalRightsPhotoArray.count;
            [self.view addSubview:self.photoPageControl];
        }
    }
    
}

#pragma mark  ----  懒加载

-(UILabel *)personalRightsTitleLabel{
    
    if (!_personalRightsTitleLabel) {
        
        NSString * str = @"权益名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _personalRightsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, width, LABELHEIGHT)];
        _personalRightsTitleLabel.font = BOLDFONT14;
        _personalRightsTitleLabel.text = str;
    }
    return _personalRightsTitleLabel;
}

-(UILabel *)personalRightsLabel{
    
    if (!_personalRightsLabel) {
        
        _personalRightsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsTitleLabel.frame), CGRectGetMinY(self.personalRightsTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.personalRightsTitleLabel.frame), LABELHEIGHT)];
        _personalRightsLabel.font = FONT14;
    }
    return _personalRightsLabel;
}
-(UILabel *)startEndTimeTitleLabel{
    
    if (!_startEndTimeTitleLabel) {
        
        NSString * str = @"起止时间：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _startEndTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personalRightsTitleLabel.frame), width, LABELHEIGHT)];
        _startEndTimeTitleLabel.font = BOLDFONT14;
        _startEndTimeTitleLabel.text = str;
    }
    return _startEndTimeTitleLabel;
}

-(UILabel *)startEndTimeLabel{
    
    if (!_startEndTimeLabel) {
        
        _startEndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.startEndTimeTitleLabel.frame), CGRectGetMinY(self.startEndTimeTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.startEndTimeTitleLabel.frame), LABELHEIGHT)];
        _startEndTimeLabel.font = FONT14;
    }
    return _startEndTimeLabel;
}
-(UILabel *)personalRightsFromTitleLabel{
    
    if (!_personalRightsFromTitleLabel) {
        
        NSString * str = @"权益来源：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _personalRightsFromTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.startEndTimeTitleLabel.frame), width, LABELHEIGHT)];
        _personalRightsFromTitleLabel.font = BOLDFONT14;
        _personalRightsFromTitleLabel.text = str;
    }
    return _personalRightsFromTitleLabel;
}

-(UILabel *)personalRightsFromLabel{
    
    if (!_personalRightsFromLabel) {
        
        _personalRightsFromLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsFromTitleLabel.frame), CGRectGetMinY(self.personalRightsFromTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.personalRightsFromTitleLabel.frame), LABELHEIGHT)];
        _personalRightsFromLabel.font = FONT14;
    }
    return _personalRightsFromLabel;
}
-(UILabel *)useConditionTitleLabel{
    
    if (!_useConditionTitleLabel) {
        
        NSString * str = @"使用条件：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _useConditionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personalRightsFromTitleLabel.frame), width, LABELHEIGHT)];
        _useConditionTitleLabel.font = BOLDFONT14;
        _useConditionTitleLabel.text = str;
    }
    return _useConditionTitleLabel;
}

-(UILabel *)useConditionLabel{
    
    if (!_useConditionLabel) {
        
        _useConditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.useConditionTitleLabel.frame), CGRectGetMinY(self.useConditionTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.useConditionTitleLabel.frame), LABELHEIGHT)];
        _useConditionLabel.font = FONT14;
    }
    return _useConditionLabel;
}
-(UILabel *)enjoyConditionTitleLabel{
    
    if (!_enjoyConditionTitleLabel) {
        
        NSString * str = @"享受条件：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _enjoyConditionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.useConditionTitleLabel.frame), width, LABELHEIGHT)];
        _enjoyConditionTitleLabel.font = BOLDFONT14;
        _enjoyConditionTitleLabel.text = str;
    }
    return _enjoyConditionTitleLabel;
}

-(UILabel *)enjoyConditionLabel{
    
    if (!_enjoyConditionLabel) {
        
        _enjoyConditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.enjoyConditionTitleLabel.frame), CGRectGetMinY(self.enjoyConditionTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.enjoyConditionTitleLabel.frame), LABELHEIGHT)];
        _enjoyConditionLabel.font = FONT14;
    }
    return _enjoyConditionLabel;
}

-(UILabel *)photoRewardTitleLabel{
    
    if (!_photoRewardTitleLabel) {
        
        NSString * str = @"照片记录：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _photoRewardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.enjoyConditionTitleLabel.frame), width, LABELHEIGHT)];
        _photoRewardTitleLabel.font = BOLDFONT14;
        _photoRewardTitleLabel.text = str;
    }
    return _photoRewardTitleLabel;
}

-(UIScrollView *)photoRewardScrollView{
    
    if (!_photoRewardScrollView) {
        
        _photoRewardScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoRewardTitleLabel.frame), SCREENWIDTH, SCROLLVIEWHEIGHT)];
        _photoRewardScrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    }
    return _photoRewardScrollView;
}

-(UIPageControl *)photoPageControl{
    
    if (!_photoPageControl) {
        
        _photoPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoRewardScrollView.frame) - 20, SCREENWIDTH, 20)];
    }
    return _photoPageControl;
}

@end
