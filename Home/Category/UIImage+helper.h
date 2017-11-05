//
//  UIImage+helper.h
//  Home
//
//  Created by xianjunwang on 2017/11/5.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (helper)
+ (unsigned char*) convertUIImageToBitmapRGBA8:(UIImage*) image;
+ (UIImage*) convertBitmapRGBA8ToUIImage:(unsigned char*) buffer withWidth:(int) width withHeight:(int) height;
@end
