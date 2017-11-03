//
//  TableViewCellWithSwitch.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "TableViewCellWithSwitch.h"

@interface TableViewCellWithSwitch ()

//开关,系统默认宽高(51，31)
@property (nonatomic,strong) UISwitch * cellSwitch;

@end

@implementation TableViewCellWithSwitch

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.cellSwitch];
    }
    return self;
}

#pragma mark  ----  SET
-(void)setModelWithState:(ModelWithState *)modelWithState{
    
    _modelWithState = modelWithState;
    self.titleLabel.text = self.modelWithState.title;
    [self.cellSwitch setOn:self.modelWithState.switchState animated:YES];
}

#pragma mark  ----  懒加载

-(UISwitch *)cellSwitch{
    
    if (!_cellSwitch) {
        
        _cellSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - 51 - 10, (40 - 31) / 2, 51, 31)];
    }
    return _cellSwitch;
}

@end
