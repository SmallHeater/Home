//
//  PersonalRightsRewardingViewController.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsRewardingViewController.h"
#import "DatePickView.h"
#import "LiveWithDeleteImageView.h"





#define MAXHEIGHT 14.0
#define USECONDITIONSSTR  @"请输入使用条件"
#define ENJOYCONDITIONSSTR  @"请输入享受条件"


@interface PersonalRightsRewardingViewController ()<UITextFieldDelegate,UITextViewDelegate,DatePickViewDelegate>
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
//添加图片的view
@property (nonatomic,strong) LiveWithDeleteImageView * addImageView;
//照片记录View
@property (nonatomic,strong) UIView * photoRecordView;


//日期选择view
@property (nonatomic,strong) DatePickView * datePickerView;

//是否是选择权益开始时间
@property (nonatomic,assign) BOOL isSelectStartTime;
@end

@implementation PersonalRightsRewardingViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益录入";
    
    [self.view addSubview:self.personalRightsTitleLabel];
    [self.view addSubview:self.personalRightsTextField];
    [self.view addSubview:self.startTimeTitleLabel];
    [self.view addSubview:self.startTimeLabel];
    [self.view addSubview:self.endTimeTitleLabel];
    [self.view addSubview:self.endTimeLabel];
    [self.view addSubview:self.personalRightsFromTitleLabel];
    [self.view addSubview:self.personalRightsFromTextField];
    [self.view addSubview:self.useConditionsTitleLabel];
    [self.view addSubview:self.useConditionsTextView];
    [self.view addSubview:self.enjoyConditionsTitleLabel];
    [self.view addSubview:self.enjoyConditionsTextView];
    [self.view addSubview:self.photoRecordTitleLabel];
    [self.view addSubview:self.photoRecordView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理函数
#pragma mark  ----  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
#pragma mark  ----  UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    textView.text = @"";
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if (textView.text.length == 0) {
        
        if ([textView isEqual:self.useConditionsTextView]) {
            
            self.useConditionsTextView.text = USECONDITIONSSTR;
        }
        else if ([textView isEqual:self.enjoyConditionsTextView]){
        
            self.enjoyConditionsTextView.text = ENJOYCONDITIONSSTR;
        }
    }
}

#pragma mark  ----  DatePickViewDelegate
-(void)finishSelectedWithTimeStr:(NSString *)selectedTime{

    if (self.isSelectStartTime) {
    
        NSString * startTimeStr = [[NSString alloc] initWithString:selectedTime];
        self.startTimeLabel.text = startTimeStr;
    }
    else{
    
        NSString * endTimeStr = [[NSString alloc] initWithString:selectedTime];
        self.endTimeLabel.text = endTimeStr;
    }
}

#pragma mark  ----  自定义函数
//选择权益开始时间
-(void)startTimeLabelTaped{

    self.isSelectStartTime = YES;
    [self.view addSubview:self.datePickerView];
}


//选择权益结束时间
-(void)endTimeLabelTaped{

    self.isSelectStartTime = NO;
    [self.view addSubview:self.datePickerView];
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
        _startTimeLabel.userInteractionEnabled = YES;
        _startTimeLabel.text = @"请选择开始时间";
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimeLabelTaped)];
        [_startTimeLabel addGestureRecognizer:tap];
    }
    return _startTimeLabel;
}

-(UILabel *)endTimeTitleLabel{

    if (!_endTimeTitleLabel) {
        
        NSString * str = @"结束时间";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        _endTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.startTimeTitleLabel.frame) + 10, width, MAXHEIGHT)];
        _endTimeTitleLabel.font = FONT14;
        _endTimeTitleLabel.text = str;
    }
    return _endTimeTitleLabel;
}

-(UILabel *)endTimeLabel{

    if (!_endTimeLabel) {
        
        _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.endTimeTitleLabel.frame) + 5, CGRectGetMinY(self.endTimeTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.endTimeTitleLabel.frame), MAXHEIGHT)];
        _endTimeLabel.userInteractionEnabled = YES;
        _endTimeLabel.text = @"请选择结束时间";
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTimeLabelTaped)];
        [_endTimeLabel addGestureRecognizer:tap];
    }
    return _endTimeLabel;
}

-(UILabel *)personalRightsFromTitleLabel{

    if (!_personalRightsFromTitleLabel) {
        
        NSString * str = @"权益来源：";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        _personalRightsFromTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.endTimeTitleLabel.frame) + 10, width, MAXHEIGHT)];
        _personalRightsFromTitleLabel.text = str;
    }
    return _personalRightsFromTitleLabel;
}

-(UITextField *)personalRightsFromTextField{

    if (!_personalRightsFromTextField) {
        
        _personalRightsFromTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsFromTitleLabel.frame) + 5, CGRectGetMinY(self.personalRightsFromTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.personalRightsFromTitleLabel.frame), MAXHEIGHT)];
        _personalRightsFromTextField.placeholder = @"请输入权益来源";
    }
    return _personalRightsFromTextField;
}

-(UILabel *)useConditionsTitleLabel{

    if (!_useConditionsTitleLabel) {
        
        _useConditionsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.personalRightsFromTitleLabel.frame) + 10, SCREENWIDTH - 40, MAXHEIGHT)];
        _useConditionsTitleLabel.text = @"使用条件：";
        _useConditionsTitleLabel.font = FONT14;
    }
    return _useConditionsTitleLabel;
}

-(UITextView *)useConditionsTextView{

    if (!_useConditionsTextView) {
        
        _useConditionsTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.useConditionsTitleLabel.frame) + 10, SCREENWIDTH - 40, 100)];
        _useConditionsTextView.text = USECONDITIONSSTR;
    }
    return _useConditionsTextView;
}


-(UILabel *)enjoyConditionsTitleLabel{
    
    if (!_enjoyConditionsTitleLabel) {
        
        _enjoyConditionsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.useConditionsTextView.frame) + 10, SCREENWIDTH - 40, MAXHEIGHT)];
        _enjoyConditionsTitleLabel.text = @"享受条件：";
        _enjoyConditionsTitleLabel.font = FONT14;
    }
    return _enjoyConditionsTitleLabel;
}

-(UITextView *)enjoyConditionsTextView{
    
    if (!_enjoyConditionsTextView) {
        
        _enjoyConditionsTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.enjoyConditionsTitleLabel.frame) + 10, SCREENWIDTH - 40, 100)];
        _enjoyConditionsTextView.text = ENJOYCONDITIONSSTR;
    }
    return _enjoyConditionsTextView;
}

-(UILabel *)photoRecordTitleLabel{

    if (!_photoRecordTitleLabel) {
        
        _photoRecordTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.enjoyConditionsTextView.frame) + 10, SCREENWIDTH - 40, MAXHEIGHT)];
        _photoRecordTitleLabel.font = FONT14;
        _photoRecordTitleLabel.text = @"照片记录";
    }
    return _photoRecordTitleLabel;
}

-(LiveWithDeleteImageView *)addImageView{

    if (!_addImageView) {
        
        _addImageView = [[LiveWithDeleteImageView alloc] initWithImage:[UIImage imageNamed:@"HomeSource.bundle/photo_duf.tiff"] andFrame:CGRectMake(0, 0, 114, 69) andTarget:self andAction:@selector(addImageViewTaped:) andButtonTag:0];;
    }
    return _addImageView;
}

-(UIView *)photoRecordView{

    if (!_photoRecordView) {
        
        _photoRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoRecordTitleLabel.frame) + 10, SCREENWIDTH, 60)];
    }
    return _photoRecordView;
}


-(DatePickView *)datePickerView{
    
    if (!_datePickerView) {
        
        _datePickerView = [[DatePickView alloc] init];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}

@end
