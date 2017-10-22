//
//  TableViewCellWithBottomLine.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "TableViewCellWithBottomLine.h"

@implementation TableViewCellWithBottomLine

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self addSubview:self.bottomLineLabel];
}

#pragma mark  ----  懒加载
-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = [UIColor grayColor];
    }
    return _bottomLineLabel;
}

@end
