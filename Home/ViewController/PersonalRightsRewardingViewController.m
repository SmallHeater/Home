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
#import "PersonalRightsModel.h"
#import "CommodityDataManager.h"
#import "SHFMDBManager.h"
#import "SHUIImagePickerControllerLibrary.h"
#import "SHAssetModel.h"
#import "MBProgressHUD+BWMExtension.H"


#define MAXHEIGHT 14.0
#define VIEWHEIGHT 40
#define DELETEBTNBASETAG 1500

#define USECONDITIONSSTR  @"请输入使用条件"
#define ENJOYCONDITIONSSTR  @"请输入享受条件"

#define PERSONALRIGHTSNAME @"请输入权益名称"
#define STARTTIME @"请选择开始时间"
#define ENDTIME @"请选择结束时间"
#define PERSONALRIGHTSFROM @"请输入权益来源"




@interface PersonalRightsRewardingViewController ()<UITextFieldDelegate,UITextViewDelegate,DatePickViewDelegate>{
    
    //是否是选择权益开始时间
    BOOL isSelectStartTime;
}

//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
//权益名称view
@property (nonatomic,strong) UIView * personalRightsView;
//开始结束时间view
@property (nonatomic,strong) UIView * timeView;
//权益来源view
@property (nonatomic,strong) UIView * rightsFromView;
//使用条件view
@property (nonatomic,strong) UIView * useConditionsView;
//享受条件
@property (nonatomic,strong) UIView * enjoyConditionsView;
//照片记录view
@property (nonatomic,strong) UIView * photoRecordView;
//存放照片的scrollView
@property (nonatomic,strong) UIScrollView * photoScrollView;
//添加照片
@property (nonatomic,strong) LiveWithDeleteImageView * addImageView;

//权益名称TF
@property (nonatomic,strong) UITextField * personalRightsTextField;
//开始时间Label
@property (nonatomic,strong) UILabel * startTimeLabel;
//结束时间Label
@property (nonatomic,strong) UILabel * endTimeLabel;
//权益来源TF
@property (nonatomic,strong) UITextField * personalRightsFromTextField;
//使用条件TV
@property (nonatomic,strong) UITextView * useConditionsTextView;
//享受条件TV
@property (nonatomic,strong) UITextView * enjoyConditionsTextView;
//日期选择view
@property (nonatomic,strong) DatePickView * datePickerView;

//权益模型
@property (nonatomic,strong) PersonalRightsModel * personalRightsModel;
@end

@implementation PersonalRightsRewardingViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleLabel.text = @"个人权益录入";
    [self.navigationBar addSubview:self.finishBtn];
    
    
    [self.view addSubview:self.personalRightsView];
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.rightsFromView];
    [self.view addSubview:self.useConditionsView];
    [self.view addSubview:self.enjoyConditionsView];
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.personalRightsTextField]) {
        
        //权益名称
        self.personalRightsModel.personalRightsName = self.personalRightsTextField.text;
    }
    else if ([textField isEqual:self.personalRightsFromTextField]){
        
        //权益来源
        self.personalRightsModel.personalRightsFrom = self.personalRightsFromTextField.text;
    }
}

#pragma mark  ----  UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if ([textView.text isEqualToString:USECONDITIONSSTR] || [textView.text isEqualToString:ENJOYCONDITIONSSTR]) {
        
        textView.text = @"";
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if ([textView isEqual:self.useConditionsTextView]) {
        
        if (textView.text.length == 0) {
            
            self.personalRightsModel.personalRightsUsedConditions = @"";
            self.useConditionsTextView.text = USECONDITIONSSTR;
        }
        else{
            
            self.personalRightsModel.personalRightsUsedConditions = self.useConditionsTextView.text;
        }
    }
    else if ([textView isEqual:self.enjoyConditionsTextView]){
    
        if (textView.text.length == 0) {
            
            self.personalRightsModel.personalRightsEnjoyConditions = @"";
            self.enjoyConditionsTextView.text = USECONDITIONSSTR;
        }
        else{
            
            self.personalRightsModel.personalRightsEnjoyConditions = self.enjoyConditionsTextView.text;
        }
    }
}

#pragma mark  ----  DatePickViewDelegate
-(void)finishSelectedWithTimeStr:(NSString *)selectedTime{

    if (isSelectStartTime) {
    
        NSString * startTimeStr = [[NSString alloc] initWithString:selectedTime];
        self.startTimeLabel.text = startTimeStr;
        self.personalRightsModel.personalRightsStartTime = startTimeStr;
    }
    else{
    
        NSString * endTimeStr = [[NSString alloc] initWithString:selectedTime];
        self.endTimeLabel.text = endTimeStr;
        self.personalRightsModel.personalRightsEndTime = endTimeStr;
    }
}

#pragma mark  ----  自定义函数
//选择权益开始时间
-(void)startTimeLabelTaped{

    [self.view endEditing:YES];
    isSelectStartTime = YES;
    [self.view addSubview:self.datePickerView];
}


//选择权益结束时间
-(void)endTimeLabelTaped{

    [self.view endEditing:YES];
    isSelectStartTime = NO;
    [self.view addSubview:self.datePickerView];
}

//添加记录图片
-(void)addImageViewTaped:(UIGestureRecognizer *)ges{
 
    [SHUIImagePickerControllerLibrary goToSHUIImagePickerViewControllerWithMaxImageSelectCount:9 anResultBlock:^(NSMutableArray *arr) {
        
        NSMutableArray * modleArray = [[NSMutableArray alloc] initWithArray:arr];
        arr = nil;
        for (NSUInteger i = 0; i < modleArray.count; i++) {
            
            SHAssetModel * model = modleArray[i];
            [self.personalRightsModel.personalRightsPhotoArray addObject:model.thumbnails];
        }
        
        if (modleArray.count == 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self addLiveWithDeleteImageView];
            });
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self refreshLiveWithDeleteImageView];
            });
        }
        
    }];
}

//大图浏览
-(void)imageViewTaped:(UIGestureRecognizer *)ges{
    
    
}

//完成按钮的响应事件
-(void)finishBtnClicked:(UIButton *)finishBtn{
    
    [self.view endEditing:YES];
    
    if (!self.personalRightsModel.personalRightsName || self.personalRightsModel.personalRightsName.length < 1) {
        
        [MBProgressHUD bwm_showTitle:PERSONALRIGHTSNAME toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.personalRightsModel.personalRightsStartTime || self.personalRightsModel.personalRightsStartTime.length < 1){
        
        [MBProgressHUD bwm_showTitle:STARTTIME toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.personalRightsModel.personalRightsEndTime || self.personalRightsModel.personalRightsEndTime.length < 1){
        
        [MBProgressHUD bwm_showTitle:ENDTIME toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.personalRightsModel.personalRightsFrom || self.personalRightsModel.personalRightsFrom.length < 1){
        
        [MBProgressHUD bwm_showTitle:PERSONALRIGHTSNAME  toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.personalRightsModel.personalRightsUsedConditions || self.personalRightsModel.personalRightsUsedConditions.length < 1){
        
        [MBProgressHUD bwm_showTitle:USECONDITIONSSTR  toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.personalRightsModel.personalRightsEnjoyConditions || self.personalRightsModel.personalRightsEnjoyConditions.length < 1){
        
        [MBProgressHUD bwm_showTitle:ENJOYCONDITIONSSTR  toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else{
        
        [[CommodityDataManager sharedManager].personalRightsArray addObject:self.personalRightsModel];
        [self.navigationController popViewControllerAnimated:YES];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[SHFMDBManager sharedManager] insertModel:self.personalRightsModel];
        });
    }
}


//添加单个LiveWithDeleteImageView
-(void)addLiveWithDeleteImageView{
    
    LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.personalRightsModel.personalRightsPhotoArray.lastObject andFrame:CGRectMake((self.personalRightsModel.personalRightsPhotoArray.count - 1) * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(imageViewTaped:) andButtonTag:DELETEBTNBASETAG + self.personalRightsModel.personalRightsPhotoArray.count - 1];
    [self.photoScrollView addSubview:imageView];

  self.addImageView.frame = CGRectMake(self.personalRightsModel.personalRightsPhotoArray.count * (114 + 10), 0, 114, 69);
  self.photoScrollView.contentSize = CGSizeMake((self.personalRightsModel.personalRightsPhotoArray.count + 1) * 114 + self.personalRightsModel.personalRightsPhotoArray.count * 10, 69);
}

//刷新scrollView上面的LiveWithDeleteImageView
-(void)refreshLiveWithDeleteImageView{
    
    for (UIView * view in self.photoScrollView.subviews) {
        
        if ([view isKindOfClass:[LiveWithDeleteImageView class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    for (NSUInteger i = 0; i < self.personalRightsModel.personalRightsPhotoArray.count; i++) {
        
        LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.personalRightsModel.personalRightsPhotoArray[i] andFrame:CGRectMake(i * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(imageViewTaped:) andButtonTag:DELETEBTNBASETAG + i];
        [self.photoScrollView addSubview:imageView];
    }
    
    self.addImageView.frame = CGRectMake(self.personalRightsModel.personalRightsPhotoArray.count * (114 + 10), 0, 114, 69);
    [self.photoScrollView addSubview:self.addImageView];
    
    
    self.photoScrollView.contentSize = CGSizeMake((self.personalRightsModel.personalRightsPhotoArray.count + 1) * 114 + self.personalRightsModel.personalRightsPhotoArray.count * 10, 69);
    
}

#pragma mark  ------  懒加载
-(UIButton *)finishBtn{
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.titleLabel.font = FONT14;
        _finishBtn.frame = CGRectMake(SCREENWIDTH - 44 - 20, 20, 44, 44);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UIView *)personalRightsView{
    
    if (!_personalRightsView) {
        
        _personalRightsView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, VIEWHEIGHT)];
        
        NSString * str = @"权益名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:MAXHEIGHT];
        UILabel * personalRightsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        personalRightsTitleLabel.font = BOLDFONT14;
        personalRightsTitleLabel.text = str;
        [_personalRightsView addSubview:personalRightsTitleLabel];
        
        UITextField * personalRightsTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(personalRightsTitleLabel.frame) + 5, 0, SCREENWIDTH - 10 - CGRectGetMaxX(personalRightsTitleLabel.frame), VIEWHEIGHT)];
        personalRightsTextField.delegate = self;
        personalRightsTextField.placeholder = PERSONALRIGHTSNAME;
        personalRightsTextField.font = FONT14;
        [_personalRightsView addSubview:personalRightsTextField];
        self.personalRightsTextField = personalRightsTextField;
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_personalRightsView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_personalRightsView addSubview:bottomLineLabel];
        
    }
    return _personalRightsView;
}


-(UIView *)timeView{
    
    if (!_timeView) {
        
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personalRightsView.frame), SCREENWIDTH, VIEWHEIGHT * 2)];
        
        NSString * str = @"开始时间：";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        UILabel * startTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        startTimeTitleLabel.font = FONT14;
        startTimeTitleLabel.text = str;
        [_timeView addSubview:startTimeTitleLabel];
        
        
        UILabel * startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startTimeTitleLabel.frame) + 5, 0, SCREENWIDTH - 10 - CGRectGetMaxX(startTimeTitleLabel.frame), VIEWHEIGHT)];
        startTimeLabel.userInteractionEnabled = YES;
        startTimeLabel.font = FONT14;
        startTimeLabel.text = STARTTIME;
        [_timeView addSubview:startTimeLabel];
        self.startTimeLabel = startTimeLabel;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimeLabelTaped)];
        [startTimeLabel addGestureRecognizer:tap];
        
        
        NSString * endStr = @"结束时间：";
        float endWidth = [NSString widthWithStr:endStr andFont:FONT14 andMaxHeight:VIEWHEIGHT];
        
        UILabel * endTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(startTimeTitleLabel.frame), endWidth, VIEWHEIGHT)];
        endTimeTitleLabel.font = FONT14;
        endTimeTitleLabel.text = endStr;
        [_timeView addSubview:endTimeTitleLabel];
        
        UILabel * endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endTimeTitleLabel.frame) + 5, CGRectGetMinY(endTimeTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(endTimeTitleLabel.frame), VIEWHEIGHT)];
        endTimeLabel.userInteractionEnabled = YES;
        endTimeLabel.font = FONT14;
        endTimeLabel.text = ENDTIME;
        [_timeView addSubview:endTimeLabel];
        self.endTimeLabel = endTimeLabel;
        
        UITapGestureRecognizer * endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTimeLabelTaped)];
        [endTimeLabel addGestureRecognizer:endTap];
        
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_timeView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_timeView addSubview:bottomLineLabel];
    }
    return _timeView;
}

-(UIView *)rightsFromView{
    
    if (!_rightsFromView) {
        
        _rightsFromView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeView.frame), SCREENWIDTH, VIEWHEIGHT)];
        
        NSString * str = @"权益来源：";
        float width = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:MAXHEIGHT];
        
        UILabel * personalRightsFromTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        personalRightsFromTitleLabel.font = FONT14;
        personalRightsFromTitleLabel.text = str;
        [_rightsFromView addSubview:personalRightsFromTitleLabel];
        
        UITextField * personalRightsFromTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(personalRightsFromTitleLabel.frame) + 5, 0, SCREENWIDTH - 10 - CGRectGetMaxX(personalRightsFromTitleLabel.frame), VIEWHEIGHT)];
        personalRightsFromTextField.delegate = self;
        personalRightsFromTextField.font = FONT14;
        personalRightsFromTextField.placeholder = PERSONALRIGHTSFROM;
        [_rightsFromView addSubview:personalRightsFromTextField];
        self.personalRightsFromTextField = personalRightsFromTextField;
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_rightsFromView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_rightsFromView addSubview:bottomLineLabel];
    }
    return _rightsFromView;
}


-(UIView *)useConditionsView{
    
    if (!_useConditionsView) {
        
        _useConditionsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.rightsFromView.frame), SCREENWIDTH, VIEWHEIGHT * 3)];
        
        UILabel * useConditionsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40, VIEWHEIGHT)];
        useConditionsTitleLabel.text = @"使用条件：";
        useConditionsTitleLabel.font = FONT14;
        [_useConditionsView addSubview:useConditionsTitleLabel];
        
        UITextView * useConditionsTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(useConditionsTitleLabel.frame), SCREENWIDTH - 40, VIEWHEIGHT * 2 - 0.5)];
        useConditionsTextView.delegate = self;
        useConditionsTextView.text = USECONDITIONSSTR;
        [_useConditionsView addSubview:useConditionsTextView];
        self.useConditionsTextView = useConditionsTextView;
        
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_useConditionsView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_useConditionsView addSubview:bottomLineLabel];
    }
    return _useConditionsView;
}


-(UIView *)enjoyConditionsView{
    
    if (!_enjoyConditionsView) {
        
        _enjoyConditionsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.useConditionsView.frame), SCREENWIDTH, VIEWHEIGHT * 3)];
        
        UILabel * enjoyConditionsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, SCREENWIDTH - 40, VIEWHEIGHT)];
        enjoyConditionsTitleLabel.text = @"享受条件：";
        enjoyConditionsTitleLabel.font = FONT14;
        [_enjoyConditionsView addSubview:enjoyConditionsTitleLabel];
        
        UITextView * enjoyConditionsTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(enjoyConditionsTitleLabel.frame), SCREENWIDTH - 40, VIEWHEIGHT * 2 - 0.5)];
        enjoyConditionsTextView.delegate = self;
        enjoyConditionsTextView.text = ENJOYCONDITIONSSTR;
        [_enjoyConditionsView addSubview:enjoyConditionsTextView];
        self.enjoyConditionsTextView = enjoyConditionsTextView;
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_enjoyConditionsView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_enjoyConditionsView addSubview:bottomLineLabel];
    }
    return _enjoyConditionsView;
}

-(UIView *)photoRecordView{
    
    if (!_photoRecordView) {
        
        _photoRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.enjoyConditionsView.frame), SCREENWIDTH, VIEWHEIGHT + 74.5)];
        UILabel * photoRecordTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40, VIEWHEIGHT)];
        photoRecordTitleLabel.font = FONT14;
        photoRecordTitleLabel.text = @"照片记录：";
        [_photoRecordView addSubview:photoRecordTitleLabel];
        
        LiveWithDeleteImageView * addImageView = [[LiveWithDeleteImageView alloc] initWithImage:[UIImage imageNamed:@"HomeSource.bundle/photo_duf.tiff"] andFrame:CGRectMake(20, 0, 114, 69) andTarget:self andAction:@selector(addImageViewTaped:) andButtonTag:0];;
        [self.photoScrollView addSubview:addImageView];
        [_photoRecordView addSubview:self.photoScrollView];
        self.addImageView = addImageView;
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_photoRecordView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_photoRecordView addSubview:bottomLineLabel];
    }
    return _photoRecordView;
}

-(UIScrollView *)photoScrollView{
    
    if (!_photoScrollView) {
        
        _photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT, SCREENWIDTH, 69)];
        _photoScrollView.contentSize = CGSizeMake(SCREENWIDTH - 40, 69);
    }
    return _photoScrollView;
}


-(DatePickView *)datePickerView{
    
    if (!_datePickerView) {
        
        _datePickerView = [[DatePickView alloc] init];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}

-(PersonalRightsModel *)personalRightsModel{
    
    if (!_personalRightsModel) {
        
        _personalRightsModel = [[PersonalRightsModel alloc] init];
        _personalRightsModel.personalRightsID = [[NSUUID UUID] UUIDString];
    }
    return _personalRightsModel;
}

@end
