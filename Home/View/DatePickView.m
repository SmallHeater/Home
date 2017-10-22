//
//  DatePickView.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "DatePickView.h"

@interface DatePickView ()

//底部view
@property (nonatomic,strong) UIView * datePickBackgroundView;
//取消按钮
@property (nonatomic,strong) UIButton * cancleBtn;
//确定按钮
@property (nonatomic,strong) UIButton * sureBtn;

//时间选择器
@property (nonatomic,strong) UIDatePicker * datePicker;

@end

@implementation DatePickView

#pragma mark  ----  生命周期函数
-(instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4]; 
        [self.datePickBackgroundView addSubview:self.cancleBtn];
        [self.datePickBackgroundView addSubview:self.sureBtn];
        [self.datePickBackgroundView addSubview:self.datePicker];
        [self addSubview:self.datePickBackgroundView];
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)cancleBtnClicked:(UIButton *)cancleBtn{
    
    [self removeFromSuperview];
}

-(void)sureBtnClicked:(UIButton *)sureBtn{
    
    NSDate * selectedDate = self.datePicker.date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * selectedDateStr = [formatter stringFromDate:selectedDate];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(finishSelectedWithTimeStr:)]) {
        
        [self.delegate finishSelectedWithTimeStr:selectedDateStr];
    }
    
    [self removeFromSuperview];
}


#pragma mark  ----  懒加载

-(UIView *)datePickBackgroundView{
    
    if (!_datePickBackgroundView) {
        
        _datePickBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 300, SCREENWIDTH, 300)];
        [_datePickBackgroundView addSubview:self.cancleBtn];
        [_datePickBackgroundView addSubview:self.sureBtn];
        [_datePickBackgroundView addSubview:self.datePicker];
    }
    return _datePickBackgroundView;
}

-(UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(20, 0, 44, 44);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

-(UIButton *)sureBtn{
    
    if (!_sureBtn) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(SCREENWIDTH - 64, 0, 44, 44);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UIDatePicker *)datePicker{
    
    if (!_datePicker) {
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, CGRectGetHeight(self.datePickBackgroundView.frame) - 44)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

@end
