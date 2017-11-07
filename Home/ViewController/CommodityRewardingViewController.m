//
//  CommodityRewardingViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "CommodityRewardingViewController.h"
#import "DatePickView.h"
#import "CommodityModel.h"
#import "CommodityDataManager.h"
#import "LiveWithDeleteImageView.h"
#import "MBProgressHUD+BWMExtension.H"
#import "SHFMDBManager.h"
#import "SHUIImagePickerControllerLibrary.h"
#import "ImageCompressionController.h"



typedef NS_ENUM(NSInteger, AddImageType){
    
    CommodityImage,
    CommodityLocationImage
};

#define VIEWHEIGHT 40
#define VIEWWITHIMAGESHEIGHT 119
#define UITEXTFIEDLBASETAG  1230
#define COMMODITUIMAGEVIEWBASETAG  1300
#define LOCATIONIMAGEBASETAG  1400
#define DELETEBTNBASETAG 1900
#define COMMODITYDELETEBTNTAG 0
#define LOCATIONDELETEBTNTAG 50

#define COMMODITYNAME @"请输入商品名称"
#define COMMODITYLOCATION @"请输入存放位置"
#define COMMODITYCOUNT @"商品数量不能为0"
#define COMMODITYLIFE  @"请选择物品到期时间"


@interface CommodityRewardingViewController () <UITextFieldDelegate,DatePickViewDelegate>

//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
@property (nonatomic,strong) UIScrollView * scrollView;
//品类view
@property (nonatomic,strong) UIView * categoryView;
//商品view
@property (nonatomic,strong) UIView * commodityView;
//商品图片view
@property (nonatomic,strong) UIView * commodityImageView;
//存放物品图片的scrollView
@property (nonatomic,strong) UIScrollView * commodityImageViewScrollView;
//存放位置view
@property (nonatomic,strong) UIView * storageLocationView;
//存放位置图片view
@property (nonatomic,strong) UIView * storageLocationImageView;
//存放位置图片的scrollView
@property (nonatomic,strong) UIScrollView * locationImageViewScrollView;
//数量view
@property (nonatomic,strong) UIView * quantityView;
//有无保质期view
@property (nonatomic,strong) UIView * hasShelfLifeView;
//保质期view
@property (nonatomic,strong) UIView * shelfLifeView;
//日期label
@property (nonatomic,strong) UILabel * dateLabel;
//日期选择view
@property (nonatomic,strong) DatePickView * datePickerView;

//选中的LiveWithDeleteImageView
@property (nonatomic,strong) LiveWithDeleteImageView * tapedLiveWithDeleteImageView;

//物品模型
@property (nonatomic,strong) CommodityModel * model;

//物品图片数组
@property (nonatomic,strong) NSMutableArray * commodityImageArray;
//位置图片数组
@property (nonatomic,strong) NSMutableArray * locationImageViewArray;

@end

@implementation CommodityRewardingViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.titleLabel.text = @"录入";
    [self.navigationBar addSubview:self.finishBtn];
    
    self.model.category = [self.categoryStr copy];
    
    [self.scrollView addSubview:self.categoryView];
    [self.scrollView addSubview:self.commodityView];
    [self.scrollView addSubview:self.commodityImageView];
    [self.scrollView addSubview:self.storageLocationView];
    [self.scrollView addSubview:self.storageLocationImageView];
    [self.scrollView addSubview:self.quantityView];
    [self.scrollView addSubview:self.hasShelfLifeView];
    
    [self.view addSubview:self.scrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"物品录入页面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"物品录入页面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理函数
#pragma mark  ----  UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length > 0) {
     
        if (textField.tag == UITEXTFIEDLBASETAG) {
            
            //商品名称
            self.model.commodityName = textField.text;
        }
        else if (textField.tag == UITEXTFIEDLBASETAG + 1){
            
            //存放位置
            self.model.commodityLocation = textField.text;
        }
        else if (textField.tag == UITEXTFIEDLBASETAG + 2){
            
            //数量
            self.model.commodityCount = textField.text.intValue;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  DatePickViewDelegate

-(void)finishSelectedWithTimeStr:(NSString *)selectedTime{
    
    self.dateLabel.text = selectedTime;
    self.model.shelfLife = selectedTime;
}

#pragma mark  ----  自定义函数
//重写返回方法
-(void)backBtnClicked:(UIButton *)btn{
    
    [self.view endEditing:YES];
    [super backBtnClicked:btn];
}

//完成按钮的响应事件
-(void)finishBtnClicked:(UIButton *)finishBtn{
    
    [self.view endEditing:YES];
    
    if (!self.model.commodityName || self.model.commodityName.length < 1) {
        
        [MBProgressHUD bwm_showTitle:COMMODITYNAME toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (!self.model.commodityLocation || self.model.commodityLocation.length < 1){
        
        [MBProgressHUD bwm_showTitle:COMMODITYLOCATION toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (self.model.commodityCount == 0){
        
        [MBProgressHUD bwm_showTitle:COMMODITYCOUNT toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else if (self.model.hasShelfLife && (!self.model.shelfLife || self.model.shelfLife.length < 1)){
        
        [MBProgressHUD bwm_showTitle:COMMODITYLIFE toView:self.view hideAfter:1 msgType:BWMMBProgressHUDMsgTypeError];
    }
    else{
        
        for (NSUInteger i = 0; i < self.commodityImageArray.count; i++) {
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            NSString * imageName = [[NSString alloc] initWithFormat:@"%@%ld.png",self.model.commodityID,(long)i];
            NSString *imageFilePath = [path stringByAppendingPathComponent:imageName];
            [self.model.commodityImageArray addObject:imageName];
            
            UIImage * image = self.commodityImageArray[i];
            
            NSData * imageData = [ImageCompressionController getImageData:image];
            BOOL result =  [imageData writeToFile:imageFilePath  atomically:YES];
            if (result) {
                
                NSLog(@"物品图片写入成功");
            }
            else{
                
                NSLog(@"物品图片写入失败");
            }
        }
        
        for (NSUInteger i = 0; i < self.locationImageViewArray.count; i++) {
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            NSString * imageName = [[NSString alloc] initWithFormat:@"location%@%ld.png",self.model.commodityID,(long)i];
            NSString *imageFilePath = [path stringByAppendingPathComponent:imageName];
            [self.model.commodityLocationImagesArray addObject:imageFilePath];
            
            UIImage * image = self.locationImageViewArray[i];
            NSData * imageData = [ImageCompressionController getImageData:image];
            BOOL result =  [imageData writeToFile:imageFilePath  atomically:YES];
            if (result) {
                
                NSLog(@"位置图片写入成功");
            }
            else{
                
                NSLog(@"位置图片写入失败");
            }
        }
        
        if (self.model.hasShelfLife) {
            
             [[CommodityDataManager sharedManager].hasShelfCommodityDataArray addObject:self.model];
        }
        else{
            
             [[CommodityDataManager sharedManager].noShelfCommodityDataArray addObject:self.model];
        }
        
       
        [self.navigationController popViewControllerAnimated:YES];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[SHFMDBManager sharedManager] insertModel:self.model];
        });
    }
}

//有无保质期开关的响应
-(void)shelfSwitchValueChanged:(UISwitch *)shelfSwitch{
    
    if (shelfSwitch.isOn) {
        
        //打开
        [self.scrollView addSubview:self.shelfLifeView];
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, self.scrollView.contentSize.height + CGRectGetHeight(self.shelfLifeView.frame));
    }
    else{
        
        //关闭
        [self.shelfLifeView removeFromSuperview];
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, self.scrollView.contentSize.height - CGRectGetHeight(self.shelfLifeView.frame));
    }
    
    self.model.hasShelfLife = shelfSwitch.isOn;
}


//选择物品到期时间的响应
-(void)shelfLiftLabelTaped:(UIGestureRecognizer *)ges{
    
    [self.view addSubview:self.datePickerView];
}

//商品图片点击的响应事件
-(void)commodityImageViewTaped:(UIGestureRecognizer *)ges{

    //大图浏览
}

//添加商品图片和位置图片点击的响应事件
-(void)addImageViewTaped:(UIGestureRecognizer *)ges{
    
    self.tapedLiveWithDeleteImageView = (LiveWithDeleteImageView *)ges.view;
    
    [SHUIImagePickerControllerLibrary goToSHUIImagePickerViewControllerWithMaxImageSelectCount:9 anResultBlock:^(NSMutableArray *arr) {
        
        NSMutableArray * modleArray = [[NSMutableArray alloc] initWithArray:arr];
        arr = nil;
        
        if (self.tapedLiveWithDeleteImageView.tag == COMMODITUIMAGEVIEWBASETAG) {
            
            //物品图片
            for (NSUInteger i = 0; i < modleArray.count; i++) {
                
                SHAssetModel * model = modleArray[i];
                [self.commodityImageArray addObject:model.thumbnails];
            }
            
            if (modleArray.count == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self addImageViewWithType:CommodityImage];
                });
            }
            else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self refreshImageViewWithType:CommodityImage];
                });
            }
        }
        else if (self.tapedLiveWithDeleteImageView.tag == LOCATIONIMAGEBASETAG){
            
            //存放位置图片
            for (NSUInteger i = 0; i < modleArray.count; i++) {
                
                SHAssetModel * model = modleArray[i];
                [self.locationImageViewArray addObject:model.thumbnails];
            }
            
            if (modleArray.count == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self addImageViewWithType:CommodityLocationImage];
                });
            }
            else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self refreshImageViewWithType:CommodityLocationImage];
                });
            }
        }
    }];
    
}


//位置图片点击的响应事件
-(void)locationImageViewTaped:(UIGestureRecognizer *)ges{
    
    //大图浏览
}

//删除物品图片的响应
-(void)commodityImageDelete:(UIButton *)deleteBtn{
    
    
}

//删除位置图片的响应
-(void)locationImageDelete:(UIButton *)deleteBtn{
    
    
}

//删除图片的响应
-(void)deleteImage:(UIButton *)deleteBtn{
    
    if (deleteBtn.tag - DELETEBTNBASETAG - LOCATIONDELETEBTNTAG >= 0) {
        
        //删除位置图片
        [self.locationImageViewArray removeObjectAtIndex:(deleteBtn.tag - DELETEBTNBASETAG - LOCATIONDELETEBTNTAG)];
        [self refreshImageViewWithType:CommodityLocationImage];
    }
    else{
        
        //删除物品图片
        [self.commodityImageArray removeObjectAtIndex:(deleteBtn.tag - DELETEBTNBASETAG)];
        [self refreshImageViewWithType:CommodityImage];
    }
}

//添加物品或存放位置图片
-(void)addImageViewWithType:(AddImageType)type{
    
    switch (type) {
        case CommodityImage:{
            
            LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.commodityImageArray.lastObject andFrame:CGRectMake((self.commodityImageArray.count - 1) * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(commodityImageViewTaped:) andButtonTag:DELETEBTNBASETAG + COMMODITYDELETEBTNTAG + self.commodityImageArray.count - 1];
            imageView.deleteAction = @selector(deleteImage:);
            [self.commodityImageViewScrollView addSubview:imageView];
            
            self.tapedLiveWithDeleteImageView.frame = CGRectMake(self.commodityImageArray.count * (114 + 10), 0, 114, 69);
            self.commodityImageViewScrollView.contentSize = CGSizeMake((self.commodityImageArray.count + 1) * 114 + self.commodityImageArray.count * 10, 69);
        }
            break;
        case CommodityLocationImage:{
            
            LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.locationImageViewArray.lastObject andFrame:CGRectMake((self.locationImageViewArray.count - 1) * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(locationImageViewTaped:) andButtonTag:DELETEBTNBASETAG + LOCATIONDELETEBTNTAG  + self.locationImageViewArray.count - 1];
            imageView.deleteAction = @selector(deleteImage:);
            [self.locationImageViewScrollView addSubview:imageView];
            
            self.tapedLiveWithDeleteImageView.frame = CGRectMake(self.locationImageViewArray.count * (114 + 10), 0, 114, 69);
            self.locationImageViewScrollView.contentSize = CGSizeMake((self.locationImageViewArray.count + 1) * 114 + self.locationImageViewArray.count * 10, 69);
        }
            break;
        default:
            break;
    }
}

//刷新物品或存放位置图片
-(void)refreshImageViewWithType:(AddImageType)type{
    
    switch (type) {
        case CommodityImage:{
            
            for (UIView * view in self.commodityImageViewScrollView.subviews) {
                
                if ([view isKindOfClass:[LiveWithDeleteImageView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            
            for (NSUInteger i = 0; i < self.commodityImageArray.count; i++) {
                
                LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.commodityImageArray[i] andFrame:CGRectMake(i * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(commodityImageViewTaped:) andButtonTag:DELETEBTNBASETAG + i];
                imageView.deleteAction = @selector(deleteImage:);
                [self.commodityImageViewScrollView addSubview:imageView];
            }
            
            self.tapedLiveWithDeleteImageView.frame = CGRectMake(self.commodityImageArray.count * (114 + 10), 0, 114, 69);
            [self.commodityImageViewScrollView addSubview:self.tapedLiveWithDeleteImageView];
            
            
            self.commodityImageViewScrollView.contentSize = CGSizeMake((self.commodityImageArray.count + 1) * 114 + self.commodityImageArray.count * 10, 69);
        }
            break;
        case CommodityLocationImage:{
            
            for (UIView * view in self.locationImageViewScrollView.subviews) {
                
                if ([view isKindOfClass:[LiveWithDeleteImageView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            
            for (NSUInteger i = 0; i < self.locationImageViewArray.count; i++) {
                
                LiveWithDeleteImageView * imageView = [[LiveWithDeleteImageView alloc] initWithImage:self.locationImageViewArray[i] andFrame:CGRectMake(i * (114 + 10), 0, 114, 69) andTarget:self andAction:@selector(locationImageViewTaped:) andButtonTag:DELETEBTNBASETAG + LOCATIONDELETEBTNTAG + i];
                imageView.deleteAction = @selector(deleteImage:);
                [self.locationImageViewScrollView addSubview:imageView];
            }
            
            self.tapedLiveWithDeleteImageView.frame = CGRectMake(self.locationImageViewArray.count * (114 + 10), 0, 114, 69);
            [self.locationImageViewScrollView addSubview:self.tapedLiveWithDeleteImageView];
            
            
            self.locationImageViewScrollView.contentSize = CGSizeMake((self.locationImageViewArray.count + 1) * 114 + self.locationImageViewArray.count * 10, 69);
        }
            break;
        default:
            break;
    }
}

#pragma mark  ----  懒加载
-(UIButton *)finishBtn{
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.titleLabel.font = FONT14;
        _finishBtn.frame = CGRectMake(SCREENWIDTH - 44 - 20, 20, 44, 44);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
        _scrollView.contentSize = CGSizeMake(SCREENWIDTH, 380);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

-(UIView *)categoryView{
    
    if (!_categoryView) {
        
        _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, VIEWHEIGHT)];
        
        NSString * str = @"品类：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        //品类标题
        UILabel * categoryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        categoryTitleLabel.font = BOLDFONT14;
        categoryTitleLabel.text = str;
        [_categoryView addSubview:categoryTitleLabel];
        //品类
        UILabel * categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(categoryTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(categoryTitleLabel.frame), VIEWHEIGHT)];
        categoryLabel.font = FONT14;
        categoryLabel.text = [self.categoryStr copy];
        [_categoryView addSubview:categoryLabel];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_categoryView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_categoryView addSubview:bottomLineLabel];
    }
    return _categoryView;
}

-(UIView *)commodityView{
    
    if (!_commodityView) {
        
        _commodityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), SCREENWIDTH, VIEWHEIGHT)];
        NSString * str = @"物品：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        //商品标题
        UILabel * commodityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        commodityTitleLabel.font = BOLDFONT14;
        commodityTitleLabel.text = str;
        [_commodityView addSubview:commodityTitleLabel];
        //商品
        UITextField * commodityTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commodityTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(commodityTitleLabel.frame), VIEWHEIGHT)];
        commodityTextField.font = FONT14;
        commodityTextField.delegate = self;
        commodityTextField.tag = UITEXTFIEDLBASETAG;
        commodityTextField.placeholder = COMMODITYNAME;
        [_commodityView addSubview:commodityTextField];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_commodityView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_commodityView addSubview:bottomLineLabel];
    }
    return _commodityView;
}

-(UIView *)commodityImageView{
    
    if (!_commodityImageView) {
        
        _commodityImageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityView.frame), SCREENWIDTH, VIEWWITHIMAGESHEIGHT)];
        //商品图片标题
        UILabel * commodityImagesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40, VIEWHEIGHT)];
        commodityImagesTitleLabel.font = BOLDFONT14;
        commodityImagesTitleLabel.text = @"物品图片：";
        [_commodityImageView addSubview:commodityImagesTitleLabel];
        //商品图片
        LiveWithDeleteImageView * commodityImageView = [[LiveWithDeleteImageView alloc] initWithImage:[UIImage imageNamed:@"HomeSource.bundle/photo_duf.tiff"] andFrame:CGRectMake(0, 0, 114, 69) andTarget:self andAction:@selector(addImageViewTaped:) andButtonTag:0];
        commodityImageView.tag = COMMODITUIMAGEVIEWBASETAG;
        [self.commodityImageViewScrollView addSubview:commodityImageView];
        [_commodityImageView addSubview:self.commodityImageViewScrollView];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_commodityImageView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_commodityImageView addSubview:bottomLineLabel];
    }
    return _commodityImageView;
}

-(UIScrollView *)commodityImageViewScrollView{
    
    if (!_commodityImageViewScrollView) {
        
        _commodityImageViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, VIEWHEIGHT, SCREENWIDTH - 40, 69)];
        _commodityImageViewScrollView.contentSize = CGSizeMake(SCREENWIDTH - 40, 69);
        _commodityImageViewScrollView.showsVerticalScrollIndicator = NO;
        _commodityImageViewScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _commodityImageViewScrollView;
}

-(UIView *)storageLocationView{
    
    if (!_storageLocationView) {
        
        _storageLocationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageView.frame), SCREENWIDTH, VIEWHEIGHT)];
        NSString * str = @"存放位置：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        //存放位置标题
        UILabel * storageLocationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        storageLocationTitleLabel.font = BOLDFONT14;
        storageLocationTitleLabel.text = str;
        [_storageLocationView addSubview:storageLocationTitleLabel];
        //存放位置
        UITextField * storageLocationTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(storageLocationTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(storageLocationTitleLabel.frame), VIEWHEIGHT)];
        storageLocationTextField.font = FONT14;
        storageLocationTextField.delegate = self;
        storageLocationTextField.tag = UITEXTFIEDLBASETAG + 1;
        storageLocationTextField.placeholder = COMMODITYLOCATION;
        [_storageLocationView addSubview:storageLocationTextField];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_storageLocationView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_storageLocationView addSubview:bottomLineLabel];
    }
    return _storageLocationView;
}

-(UIView *)storageLocationImageView{
    
    if (!_storageLocationImageView) {
        
        _storageLocationImageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.storageLocationView.frame), SCREENWIDTH, VIEWWITHIMAGESHEIGHT)];
        //存放位置照片标题
        UILabel * storageLocationImagesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40, VIEWHEIGHT)];
        storageLocationImagesTitleLabel.font = BOLDFONT14;
        storageLocationImagesTitleLabel.text = @"存放位置图片：";
        [_storageLocationImageView addSubview:storageLocationImagesTitleLabel];
        //存放位置照片
        LiveWithDeleteImageView * locationImageView = [[LiveWithDeleteImageView alloc] initWithImage:[UIImage imageNamed:@"HomeSource.bundle/photo_duf.tiff"] andFrame:CGRectMake(0, 0, 114, 69) andTarget:self andAction:@selector(addImageViewTaped:) andButtonTag:0];
        locationImageView.tag = LOCATIONIMAGEBASETAG;
        [self.locationImageViewScrollView addSubview:locationImageView];
        [_storageLocationImageView addSubview:self.locationImageViewScrollView];
        
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_storageLocationImageView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_storageLocationImageView addSubview:bottomLineLabel];
    }
    return _storageLocationImageView;
}

-(UIScrollView *)locationImageViewScrollView{
    
    if (!_locationImageViewScrollView) {
        
        _locationImageViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, VIEWHEIGHT, SCREENWIDTH - 40, 69)];
        _locationImageViewScrollView.contentSize = CGSizeMake(SCREENWIDTH - 40, 69);
        _locationImageViewScrollView.showsVerticalScrollIndicator = NO;
        _locationImageViewScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _locationImageViewScrollView;
}

-(UIView *)quantityView{
    
    if (!_quantityView) {
        
        _quantityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.storageLocationImageView.frame), SCREENWIDTH, VIEWHEIGHT)];
        //数量标题
        NSString * str = @"数量：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        
        UILabel * numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        numberTitleLabel.font = BOLDFONT14;
        numberTitleLabel.text = str;
        [_quantityView addSubview:numberTitleLabel];
        //商品数量
        UITextField * numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(numberTitleLabel.frame), VIEWHEIGHT)];
        numberTextField.font = FONT14;
        numberTextField.delegate = self;
        numberTextField.tag = UITEXTFIEDLBASETAG + 2;
        numberTextField.placeholder = @"请输入物品数量";
        numberTextField.text = @"1";
        [_quantityView addSubview:numberTextField];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_quantityView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_quantityView addSubview:bottomLineLabel];
    }
    return _quantityView;
}

-(UIView *)hasShelfLifeView{
    
    if (!_hasShelfLifeView) {
        
        _hasShelfLifeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.quantityView.frame), SCREENWIDTH, VIEWHEIGHT)];
        NSString * str = @"有无保质期：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        //有无保质期标题
        UILabel * hasShelfLifeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        hasShelfLifeTitleLabel.font = BOLDFONT14;
        hasShelfLifeTitleLabel.text = str;
        [_hasShelfLifeView addSubview:hasShelfLifeTitleLabel];
        
        //有无保质期开关
        UISwitch * shelfSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - 51 - 20, (40 - 31) / 2, 51, 31)];
        [shelfSwitch addTarget:self action:@selector(shelfSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_hasShelfLifeView addSubview:shelfSwitch];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_hasShelfLifeView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_hasShelfLifeView addSubview:bottomLineLabel];
    }
    return _hasShelfLifeView;
}

-(UIView *)shelfLifeView{
    
    if (!_shelfLifeView) {
        
        _shelfLifeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hasShelfLifeView.frame), SCREENWIDTH, VIEWHEIGHT)];
        NSString * str = @"保质期：";
        float width = [NSString widthWithStr:str andFont:BOLDFONT14 andMaxHeight:VIEWHEIGHT];
        //保质期标题
        UILabel * shelfLifeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width, VIEWHEIGHT)];
        shelfLifeTitleLabel.font = BOLDFONT14;
        shelfLifeTitleLabel.text = str;
        [_shelfLifeView addSubview:shelfLifeTitleLabel];
        //保质期
        UILabel * shelfLifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shelfLifeTitleLabel.frame) + 5, 0, SCREENWIDTH - CGRectGetMaxX(shelfLifeTitleLabel.frame), VIEWHEIGHT)];
        shelfLifeLabel.font = FONT14;
        shelfLifeLabel.text = COMMODITYLIFE;
        [_shelfLifeView addSubview:shelfLifeLabel];
        self.dateLabel = shelfLifeLabel;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shelfLiftLabelTaped:)];
        [shelfLifeLabel addGestureRecognizer:tap];
        shelfLifeLabel.userInteractionEnabled = YES;
        
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_shelfLifeView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_shelfLifeView addSubview:bottomLineLabel];
    }
    return _shelfLifeView;
}

-(DatePickView *)datePickerView{
    
    if (!_datePickerView) {
        
        _datePickerView = [[DatePickView alloc] init];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}

-(CommodityModel *)model{
    
    if (!_model) {
        
        _model = [[CommodityModel alloc] init];
        //生成唯一ID
        _model.commodityID = [[NSUUID UUID] UUIDString];
        _model.categoryID = @"123";
        _model.commodityCount = 1;
    }
    return _model;
}

-(NSMutableArray *)commodityImageArray{
    
    if (!_commodityImageArray) {
        
        _commodityImageArray = [[NSMutableArray alloc] init];
    }
    return _commodityImageArray;
}

-(NSMutableArray *)locationImageViewArray{
    
    if (!_locationImageViewArray) {
        
        _locationImageViewArray = [[NSMutableArray alloc] init];
    }
    return _locationImageViewArray;
}

@end
