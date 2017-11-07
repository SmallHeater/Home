//
//  ImageCompressionController.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/27.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "ImageCompressionController.h"
#import "UIImage+helper.h"


@implementation ImageCompressionController
//传入图片大小（内存），返回压缩系数
+(float)getCompressionFactorWithLength:(float)imageLength andExpextLength:(float)expectLength;{

    /*
     根据数据实例记录，得到压缩系数和压缩后内存大小和图片原来大小之间的关系：
     压缩系数:压缩后的内存大小和原图片大小比;
     压缩系数0.9:压缩后图片大小和原图大小比0.4;
     0.8:0.32;
     0.7:0.29;
     0.6:0.22;
     0.5:0.15;
     0.4:0.10;
     0.3:0.08;
     0.2:0.06;
     0.1:0.05;
     0.01:0.05;
     2:1;
     */
    
    if (imageLength == 0) {
        
        return 1;
    }else if (expectLength == 0){
    
        return 0.001;
    }
    
    
    //压缩系数
    NSArray * coefficientArray = [[NSArray alloc] initWithObjects:@"0.9",@"0.8",@"0.7",@"0.6",@"0.5",@"0.4",@"0.3",@"0.2",@"0.1",@"0.01",@"0.01", nil];
    //比例系数
    NSMutableArray * proportionArray = [[NSMutableArray alloc] initWithObjects:@"0.4",@"0.32",@"0.29",@"0.22",@"0.15",@"0.10",@"0.08",@"0.06",@"0.05",@"0.05", nil];
    float proportionResultValue = expectLength / imageLength;
    
    NSString * proportionResultStr = [[NSString alloc] initWithFormat:@"%.2f",proportionResultValue];
    [proportionArray addObject:proportionResultStr];
    
    [proportionArray sortUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        
        return obj1.floatValue < obj2.floatValue;
    }];
    
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < proportionArray.count; i++) {
        
        if ([proportionArray[i] isEqualToString:proportionResultStr]) {
            
            index = i;
            break;
        }
    }
    
    NSString * coefficientStr = coefficientArray[index];
    
    //NSLog(@"过程：%.2f,%ld,%.2f",proportionResultValue,(long)index,coefficientStr.floatValue);
    
    return coefficientStr.floatValue;
}

+(NSData *)getImageData:(UIImage *)image{

    NSData * resultData;
    
    NSData * jgegImageData = UIImageJPEGRepresentation(image, 1);
    if (jgegImageData) {
        
        float length = [jgegImageData length] / 1000;
        NSData * photoAddedWatermarkData;
        // 1、压缩
        if (length > 600.0) {
            
            float radio = [ImageCompressionController getCompressionFactorWithLength:length andExpextLength:600];
            //需要压缩
            photoAddedWatermarkData=UIImageJPEGRepresentation(image,1);
        }
        else{
            
            photoAddedWatermarkData=UIImageJPEGRepresentation(image, 1);
        }
        
        resultData = photoAddedWatermarkData;
    }
    else{
        
        NSData * pngImageData =UIImagePNGRepresentation(image);
        if (pngImageData) {
            
            resultData = pngImageData;
        }
        else{
            
            //图片两种转换data方式都得到nil，处理
            unsigned char * bitmap = [UIImage convertUIImageToBitmapRGBA8:image];
            
            int width = image.size.width;
            
            int height = image.size.height;
            
            UIImage * imageCopy = [UIImage convertBitmapRGBA8ToUIImage:bitmap withWidth:width withHeight:height];
            
            NSData * imageCopyData =UIImageJPEGRepresentation(imageCopy,1);
            if (imageCopyData) {
                
                float length = [imageCopyData length] / 1000;
                NSData * photoAddedWatermarkData;
                // 1、压缩
                if (length > 600.0) {
                    
                    float radio = [ImageCompressionController getCompressionFactorWithLength:length andExpextLength:600];
                    //需要压缩
                    photoAddedWatermarkData=UIImageJPEGRepresentation(imageCopy,1);
                }
                else{
                    
                    photoAddedWatermarkData=UIImageJPEGRepresentation(imageCopy, 1);
                }
                
                resultData = photoAddedWatermarkData;
            }
            
        }
    }
    
    return resultData;
}

@end
