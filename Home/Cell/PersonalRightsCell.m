//
//  PersonalRightsCell.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsCell.h"

#define LABELHEIGHT 20


@interface PersonalRightsCell ()
//权益名称title
@property (nonatomic,strong) UILabel * personalRightsNameTitleLabel;

//起止时间title
@property (nonatomic,strong) UILabel * startEndTimeTitleLabel;

//权益来源title
@property (nonatomic,strong) UILabel * personalRightsFromTitleLabel;

@end


@implementation PersonalRightsCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.personalRightsNameTitleLabel];
        [self addSubview:self.personalRightsNameLabel];
        [self addSubview:self.startEndTimeTitleLabel];
        [self addSubview:self.startEndTimeLabel];
        [self addSubview:self.personalRightsFromTitleLabel];
        [self addSubview:self.personalRightsFromLabel];
        
        self.bottomLineLabel.frame = CGRectMake(0, 60, SCREENWIDTH, 0.5);
    }
    return self;
}


#pragma mark  ----  懒加载
-(UILabel *)personalRightsNameTitleLabel{
    
    if (!_personalRightsNameTitleLabel) {
        
        NSString * str = @"权益名称：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        
        _personalRightsNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, LABELHEIGHT)];
        _personalRightsNameTitleLabel.font = BOLDFONT14;
        _personalRightsNameTitleLabel.text = str;
    }
    return _personalRightsNameTitleLabel;
}


-(UILabel *)personalRightsNameLabel{
    
    if (!_personalRightsNameLabel) {
        
        _personalRightsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsNameTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(self.personalRightsNameTitleLabel.frame), LABELHEIGHT)];
        _personalRightsNameLabel.font = FONT14;
        _personalRightsNameLabel.text = @"";
    }
    return _personalRightsNameLabel;
}

-(UILabel *)startEndTimeTitleLabel{
    
    if (!_startEndTimeTitleLabel) {
        
        NSString * str = @"起止时间：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        
        _startEndTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.personalRightsNameTitleLabel.frame), width, LABELHEIGHT)];
        _startEndTimeTitleLabel.font = BOLDFONT14;
        _startEndTimeTitleLabel.text = str;
    }
    return _startEndTimeTitleLabel;
}


-(UILabel *)startEndTimeLabel{
    
    if (!_startEndTimeLabel) {
        
        _startEndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.startEndTimeTitleLabel.frame) + 5, CGRectGetMinY(self.startEndTimeTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.startEndTimeTitleLabel.frame), LABELHEIGHT)];
        _startEndTimeLabel.font = FONT14;
        _startEndTimeLabel.text = @"";
    }
    return _startEndTimeLabel;
}

-(UILabel *)personalRightsFromTitleLabel{
    
    if (!_personalRightsFromTitleLabel) {
        
        NSString * str = @"权益来源：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:LABELHEIGHT];
        
        _personalRightsFromTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.startEndTimeTitleLabel.frame), width, LABELHEIGHT)];
        _personalRightsFromTitleLabel.font = BOLDFONT14;
        _personalRightsFromTitleLabel.text = str;
    }
    return _personalRightsFromTitleLabel;
}


-(UILabel *)personalRightsFromLabel{
    
    if (!_personalRightsFromLabel) {
        
        _personalRightsFromLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personalRightsFromTitleLabel.frame) + 5, CGRectGetMinY(self.personalRightsFromTitleLabel.frame), SCREENWIDTH - CGRectGetMaxX(self.personalRightsFromTitleLabel.frame), LABELHEIGHT)];
        _personalRightsFromLabel.font = FONT14;
        _personalRightsFromLabel.text = @"";
    }
    return _personalRightsFromLabel;
}



@end
