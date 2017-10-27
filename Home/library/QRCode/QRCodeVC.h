//
//  QRCodeVC.h
//  shikeApp
//
//  Created by 淘发现4 on 16/1/7.
//  Copyright © 2016年 淘发现1. All rights reserved.
//

#import "JHLiveBaseViewController.h"

typedef void (^myBlock) (NSString *resuat);

@interface QRCodeVC : JHLiveBaseViewController
@property (copy,nonatomic)myBlock resuatBlock;
@end
