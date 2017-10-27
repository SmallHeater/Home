//
//  QRCodeVC.m
//  shikeApp
//
//  Created by 淘发现4 on 16/1/7.
//  Copyright © 2016年 淘发现1. All rights reserved.
//

#import "QRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeAreaView.h"
#import "QRCodeBacgrouView.h"
#import "UIViewExt.h"



@interface QRCodeVC()<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession * session;//输入输出的中间桥梁
}

//半透明背景
@property (nonatomic,strong) QRCodeBacgrouView * backgroundView;
//扫描区域
@property (nonatomic,strong) QRCodeAreaView * areaView;

@end

@implementation QRCodeVC

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.navTitle = @"扫一扫";
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.areaView];
    
    [self setQRCode];
}

#pragma mark  ----  自定义函数
-(void)setQRCode{

    /**
     *  初始化二维码扫描
     */
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置识别区域
    //深坑，这个值是按比例0~1设置，而且X、Y要调换位置，width、height调换位置
    output.rectOfInterest = CGRectMake(self.areaView.y/MAINHEIGHT, self.areaView.x/MAINWIDTH, self.areaView.height/MAINHEIGHT, self.areaView.width/MAINWIDTH);
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码)
    output.metadataObjectTypes=@[AVMetadataObjectTypeCode128Code];
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
}

#pragma mark  ----  代理函数
#pragma mark  ----  AVCaptureMetadataOutputObjectsDelegate
//二维码扫描的回调
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];//停止扫描
        [_areaView stopAnimaion];//暂停动画
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        //输出扫描字符串
        self.resuatBlock(metadataObject.stringValue);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark  ----  懒加载

-(QRCodeBacgrouView *)backgroundView{

    if (!_backgroundView) {
        
        _backgroundView = [[QRCodeBacgrouView alloc]initWithFrame:CGRectMake(0, 64, MAINWIDTH, MAINHEIGHT - 64)];
    }
    return _backgroundView;
}
-(QRCodeAreaView *)areaView{

    if (!_areaView) {
        
        _areaView = [[QRCodeAreaView alloc]initWithFrame:CGRectMake((MAINWIDTH - 218)/2, (MAINHEIGHT - 218)/2, 218, 218)];
        //提示文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_areaView.frame) + 10, MAINWIDTH, 218)];
        label.text = @"将条形码放入框内，即可自动识别";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    return _areaView;
}

@end
