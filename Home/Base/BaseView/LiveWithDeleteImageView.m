//
//  EvaImageView.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/5.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "LiveWithDeleteImageView.h"

@interface LiveWithDeleteImageView ()

@property (nonatomic,strong) UIButton * btn;
@property (nonatomic,weak) id target;
@end


@implementation LiveWithDeleteImageView

#pragma mark  ----  生命周期函数
//实例化方法，传递图片的点击事件
-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)rect andTarget:(id)target andAction:(SEL)action andButtonTag:(NSUInteger)btnTag{

    self = [super initWithFrame:rect];
    if (self) {
        self.showImg = image;
        self.target = target;
        self.imageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:tap];
        
        self.btn.frame = CGRectMake(rect.size.width - 22, 0, 22, 22);
        self.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 6, 0);
        if (btnTag > 0) {
            
            self.btn.tag = btnTag;
        }
        self.btn.hidden = YES;
        [self addSubview:self.btn];
    }
    return self;
}

#pragma mark  ----  SET
-(void)setDeleteAction:(SEL)deleteAction{

    _deleteAction = deleteAction;
    if (deleteAction) {
        
        self.btn.hidden = NO;
        [self.btn addTarget:self.target action:deleteAction forControlEvents:UIControlEventTouchUpInside];
    }
    else{
    
        self.btn.hidden = YES;
    }
}

-(void)setShowImg:(UIImage *)showImg{

    _showImg = showImg;
    self.imageView.image = showImg;
}

#pragma mark  ----  懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"HomeSource/delete_ful.tiff"] forState:UIControlStateNormal];
    }
    return _btn;
}

@end
