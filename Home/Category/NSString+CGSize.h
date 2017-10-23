//
//  NSString+CGSize.h
//  Home
//
//  Created by xianjunwang on 2017/10/23.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//


@interface NSString (CGSize)
+(float)widthWithStr:(NSString *)str andFont:(UIFont *)font andMaxHeight:(float)maxHeight;
+(float)heightWithStr:(NSString *)str andFont:(UIFont *)font andMaxWidth:(float)maxWidth;
@end
