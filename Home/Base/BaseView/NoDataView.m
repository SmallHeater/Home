//
//  NoDataView.m
//  Home
//
//  Created by xianjunwang on 2017/11/4.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "NoDataView.h"


@interface NoDataView ()
@property (nonatomic,strong) UIImageView * noDataImageView;
@end

@implementation NoDataView

#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.noDataImageView];
    }
    return self;
}

#pragma mark  ----  懒加载
-(UIImageView *)noDataImageView{
    
    if (!_noDataImageView) {
        
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 130) / 2, (self.frame.size.height - 76) / 2, 130, 76)];
        _noDataImageView.image = [UIImage imageNamed:@"HomeSource.bundle/noData.tiff"];
    }
    return _noDataImageView;
}

@end
