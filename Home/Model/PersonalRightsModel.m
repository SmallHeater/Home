//
//  QuanyiModel.m
//  Home
//
//  Created by xianjunwang on 2017/11/1.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "PersonalRightsModel.h"

@implementation PersonalRightsModel

#pragma mark  ----  懒加载

-(NSMutableArray *)personalRightsPhotoArray{
    
    if (!_personalRightsPhotoArray) {
        
        _personalRightsPhotoArray = [[NSMutableArray alloc] init];
    }
    return _personalRightsPhotoArray;
}

@end
