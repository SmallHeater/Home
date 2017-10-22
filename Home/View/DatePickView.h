//
//  DatePickView.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  日期选择View

#import "BaseView.h"


@protocol DatePickViewDelegate <NSObject>
//2016-01-01
-(void)finishSelectedWithTimeStr:(NSString *)selectedTime;


@end

@interface DatePickView : BaseView
@property (nonatomic,weak) id<DatePickViewDelegate>delegate;
-(instancetype)init;
@end





