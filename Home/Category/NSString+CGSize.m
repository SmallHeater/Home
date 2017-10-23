//
//  NSString+CGSize.m
//  Home
//
//  Created by xianjunwang on 2017/10/23.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "NSString+CGSize.h"

@implementation NSString (CGSize)


+(float)widthWithStr:(NSString *)str andFont:(UIFont *)font andMaxHeight:(float)maxHeight{
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREENWIDTH, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

+(float)heightWithStr:(NSString *)str andFont:(UIFont *)font andMaxWidth:(float)maxWidth{
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(maxWidth, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}
@end
