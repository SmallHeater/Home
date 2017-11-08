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
@property (nonatomic,strong) UILabel * photoRewardScrollView;
@end

@implementation PersonalRightsDetailViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益详情";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  懒加载

-(UILabel *)personalRightsTitleLabel{
    
    if (!_personalRightsTitleLabel) {
        
        NSString * str = @"权益名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        _personalRightsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, width, LABELHEIGHT)];
        _personalRightsTitleLabel.font = BOLDFONT14;
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


@end
