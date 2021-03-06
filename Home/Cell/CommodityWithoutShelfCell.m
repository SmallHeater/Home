//
//  CommodityTableViewCell.m
//  Home
//
//  Created by xianjunwang on 2017/10/23.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityWithoutShelfCell.h"
#import "NSString+CGSize.h"
#import "CommodityModel.h"



@interface CommodityWithoutShelfCell ()



//物品名标题
@property (nonatomic,strong) UILabel * commodityNameTitleLabel;
//物品名
@property (nonatomic,strong) UILabel * commodityNameLabel;
//物品存放位置标题
@property (nonatomic,strong) UILabel * commodityLocationTitleLabel;
//物品存放位置
@property (nonatomic,strong) UILabel * commodityLocationLabel;
//物品数量标题
@property (nonatomic,strong) UILabel * commodityCountTitleLabel;
//底部分割线
@property (nonatomic,strong) UILabel * bottomLine;

@end

@implementation CommodityWithoutShelfCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.commodityImageView];
        [self addSubview:self.commodityNameTitleLabel];
        [self addSubview:self.commodityNameLabel];
        [self addSubview:self.commodityLocationTitleLabel];
        [self addSubview:self.commodityLocationLabel];
        [self addSubview:self.commodityCountTitleLabel];
        [self addSubview:self.commodityCountLabel];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark  ----  SET
-(void)setCommodityModel:(CommodityModel *)commodityModel{
    
    _commodityModel = commodityModel;
    
    if (self.commodityModel.commodityImageArray && self.commodityModel.commodityImageArray.count > 0) {
    
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *imageFilePath = [path stringByAppendingPathComponent:self.commodityModel.commodityImageArray[0]];
        
        self.commodityImageView.image = [UIImage imageWithContentsOfFile:imageFilePath];
    }
    
    self.commodityNameLabel.text = self.commodityModel.commodityName;
    self.commodityLocationLabel.text = self.commodityModel.commodityLocation;
    self.commodityCountLabel.text = [[NSString alloc] initWithFormat:@"%ld",(long)self.commodityModel.commodityCount];
}

#pragma mark  ----  懒加载
-(UIImageView *)commodityImageView{
    
    if (!_commodityImageView) {
        
        _commodityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _commodityImageView.backgroundColor = [UIColor grayColor];
    }
    return _commodityImageView;
}

-(UILabel *)commodityNameTitleLabel{
    
    if (!_commodityNameTitleLabel) {
        
        NSString * str = @"物品名:";
        float commodityNameTitleLabelWidth = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:LABELHEIGHT];
        
        _commodityNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityImageView.frame) + 10, 14, commodityNameTitleLabelWidth, LABELHEIGHT)];
        _commodityNameTitleLabel.font = FONT14;
        _commodityNameTitleLabel.text = str;
    }
    return _commodityNameTitleLabel;
}

-(UILabel *)commodityNameLabel{
    
    if (!_commodityNameLabel) {
        
        _commodityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityNameTitleLabel.frame), CGRectGetMinY(self.commodityNameTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.commodityNameTitleLabel.frame), CGRectGetHeight(self.commodityNameTitleLabel.frame))];
        _commodityNameLabel.font = FONT14;
    }
    return _commodityNameLabel;
}

-(UILabel *)commodityLocationTitleLabel{
    
    if (!_commodityLocationTitleLabel) {
        
        NSString * str = @"物品存放位置:";
        float commodityLocationTitleLabelWidth = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:LABELHEIGHT];
        
        _commodityLocationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityImageView.frame) + 10, CGRectGetMaxY(self.commodityNameTitleLabel.frame) + 4, commodityLocationTitleLabelWidth, LABELHEIGHT)];
        _commodityLocationTitleLabel.font = FONT14;
        _commodityLocationTitleLabel.text = str;
    }
    return _commodityLocationTitleLabel;
}

-(UILabel *)commodityLocationLabel{
    
    if (!_commodityLocationLabel) {
        
        _commodityLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityLocationTitleLabel.frame), CGRectGetMinY(self.commodityLocationTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.commodityLocationTitleLabel.frame), CGRectGetHeight(self.commodityLocationTitleLabel.frame))];
        _commodityLocationLabel.font = FONT14;
    }
    return _commodityLocationLabel;
}

-(UILabel *)commodityCountTitleLabel{
    
    if (!_commodityCountTitleLabel) {
        
        NSString * str = @"物品数量:";
        float commodityCountTitleLabelWidth = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:LABELHEIGHT];
        
        _commodityCountTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityImageView.frame) + 10, CGRectGetMaxY(self.commodityLocationTitleLabel.frame) + 4, commodityCountTitleLabelWidth, LABELHEIGHT)];
        _commodityCountTitleLabel.font = FONT14;
        _commodityCountTitleLabel.text = str;
    }
    return _commodityCountTitleLabel;
}

-(UILabel *)commodityCountLabel{
    
    if (!_commodityCountLabel) {
        
        _commodityCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityCountTitleLabel.frame), CGRectGetMinY(self.commodityCountTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.commodityCountTitleLabel.frame), CGRectGetHeight(self.commodityCountTitleLabel.frame))];
        _commodityCountLabel.font = FONT14;
    }
    return _commodityCountLabel;
}


-(UILabel *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageView.frame) + 10, SCREENWIDTH, 0.5)];
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}
@end
