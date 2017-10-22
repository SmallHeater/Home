//
//  TableViewCellWithTitle.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "TableViewCellWithTitle.h"

@interface TableViewCellWithTitle ()

@end


@implementation TableViewCellWithTitle

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.titleLabel];
        self.bottomLineLabel.frame = CGRectMake(0, 39.5, SCREENWIDTH, 0.5);
    }
    return self;
}

-(void)setModelWithTitle:(ModelWithTitle *)modelWithTitle{
    
    _modelWithTitle = modelWithTitle;
    self.titleLabel.text = @"";
    self.titleLabel.text = self.modelWithTitle.title;
}

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.font = FONT14;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

@end
