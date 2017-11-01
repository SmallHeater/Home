//
//  PersonalRightsRewardingViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsRewardingViewController.h"


#define MAXHEIGHT 14.0

@interface PersonalRightsRewardingViewController ()
//权益名称Title
@property (nonatomic,strong) UILabel * personalRightsTitleLabel;
//权益名称TF
@property (nonatomic,strong) UITextField * personalRightsTextField;
//开始时间Title
@property (nonatomic,strong) UILabel * startTimeTitleLabel;
//开始时间Label
@property (nonatomic,strong) UILabel * startTimeLabel;
//结束时间Title
@property (nonatomic,strong) UILabel * endTimeTitleLabel;
//结束时间Label
@property (nonatomic,strong) UILabel * endTimeLabel;
//权益来源Title
@property (nonatomic,strong) UILabel * personalRightsFromTitleLabel;
//权益来源TF
@property (nonatomic,strong) UITextField * personalRightsFromTextField;
//使用条件Title
@property (nonatomic,strong) UILabel * useConditionsTitleLabel;
//使用条件TV
@property (nonatomic,strong) UITextView * useConditionsTextView;
//享受条件Title
@property (nonatomic,strong) UILabel * enjoyConditionsTitleLabel;
//享受条件TV
@property (nonatomic,strong) UITextView * enjoyConditionsTextView;
//照片记录Title
@property (nonatomic,strong) UILabel * photoRecordTitleLabel;
//照片记录View
@property (nonatomic,strong) UIView * photoRecordView;
@end

@implementation PersonalRightsRewardingViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益录入";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ------  懒加载

-(UILabel *)personalRightsTitleLabel{
    
    if (!_personalRightsTitleLabel) {
        
        NSString * str = @"权益名称";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        _personalRightsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, width, MAXHEIGHT)];
        _personalRightsTitleLabel.font = FONT14;
        _personalRightsTitleLabel.text = str;
    }
    return _personalRightsTitleLabel;
}


-(UITextField *)personalRightsTextField{
    
    if (!_personalRightsTextField) {
        
        _personalRightsTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsTitleLabel.frame) + 5, CGRectGetMinY(self.personalRightsTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.personalRightsTitleLabel.frame), MAXHEIGHT)];
        _personalRightsTextField.placeholder = @"请输入权益名称";
    }
    return _personalRightsTextField;
}

-(UILabel *)startTimeTitleLabel{
    
    if (!_startTimeTitleLabel) {
        
        NSString * str = @"开始时间";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        _startTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.personalRightsTitleLabel.frame) + 10, width, MAXHEIGHT)];
        _startTimeTitleLabel.font = FONT14;
        _startTimeTitleLabel.text = str;
    }
    return _startTimeTitleLabel;
}

-(UILabel *)startTimeLabel{
    
    if (!_startTimeLabel) {
        
        _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.startTimeTitleLabel.frame) + 5, CGRectGetMinY(self.startTimeTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.startTimeTitleLabel.frame), MAXHEIGHT)];
        _startTimeLabel.text = @"请选择开始时间";
    }
    return _startTimeLabel;
}

@end
