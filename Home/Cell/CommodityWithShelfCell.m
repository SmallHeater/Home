//
//  CommodityWithShelfCell.m
//  Home
//
//  Created by xianjunwang on 2017/11/7.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityWithShelfCell.h"
#import "CommodityModel.h"


@interface CommodityWithShelfCell ()
//物品到期时间标题
@property (nonatomic,strong) UILabel * commodityShelfLifeTitleLabel;
//物品到期时间
@property (nonatomic,strong) UILabel * commodityShelfLifeLabel;
@end

@implementation CommodityWithShelfCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.commodityShelfLifeTitleLabel];
        [self addSubview:self.commodityShelfLifeLabel];
    }
    return self;
}

#pragma mark  ----  SET
-(void)setCommodityModel:(CommodityModel *)commodityModel{
    
    [super setCommodityModel:commodityModel];
    self.commodityShelfLifeLabel.text = self.commodityModel.shelfLife;
}

#pragma mark  ----  懒加载
-(UILabel *)commodityShelfLifeTitleLabel{
    
    if (!_commodityShelfLifeTitleLabel) {
        
        NSString * str = @"物品到期时间:";
        float commodityShelfLifeTitleLabelWidth = [NSString widthWithStr:str andFont:FONT14 andMaxHeight:LABELHEIGHT];
        
        _commodityShelfLifeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityImageView.frame) + 10, CGRectGetMaxY(self.commodityCountLabel.frame) + 4, commodityShelfLifeTitleLabelWidth, LABELHEIGHT)];
        _commodityShelfLifeTitleLabel.font = FONT14;
        _commodityShelfLifeTitleLabel.text = str;
    }
    return _commodityShelfLifeTitleLabel;
}

-(UILabel *)commodityShelfLifeLabel{
    
    if (!_commodityShelfLifeLabel) {
        
        _commodityShelfLifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commodityShelfLifeTitleLabel.frame), CGRectGetMinY(self.commodityShelfLifeTitleLabel.frame), SCREENWIDTH - 10 - CGRectGetMaxX(self.commodityShelfLifeTitleLabel.frame), CGRectGetHeight(self.commodityShelfLifeTitleLabel.frame))];
        _commodityShelfLifeLabel.font = FONT14;
    }
    return _commodityShelfLifeLabel;
}

@end
