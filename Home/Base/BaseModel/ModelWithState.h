//
//  ModelWithState.h
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  有标题和开关状态的模型

#import "ModelWithTitle.h"

@interface ModelWithState : ModelWithTitle

//开关状态
@property (nonatomic,assign) BOOL switchState;

@end
