//
//  RewardingViewController.m
//  Home
//
//  Created by xianjunwang on 2017/10/22.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "RewardingViewController.h"
#import "DatePickView.h"
#import "CommodityModel.h"
#import "CommodityDataManager.h"
#import "LiveWithDeleteImageView.h"

#define VIEWHEIGHT 40
#define VIEWWITHIMAGESHEIGHT 119
#define UITEXTFIEDLBASETAG  1230


@interface RewardingViewController () <UITextFieldDelegate,DatePickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
@property (nonatomic,strong) UIScrollView * scrollView;
//品类view
@property (nonatomic,strong) UIView * categoryView;
//商品view
@property (nonatomic,strong) UIView * commodityView;
//商品图片view
@property (nonatomic,strong) UIView * commodityImageView;
//存放位置view
@property (nonatomic,strong) UIView * storageLocationView;
//存放位置图片view
@property (nonatomic,strong) UIView * storageLocationImageView;
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

//物品模型
@property (nonatomic,strong) CommodityModel * model;
 
@end

@implementation RewardingViewController

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
            self.model.commodityCount = textField.text.integerValue;
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

#pragma mark  ----  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark  ----  自定义函数
//重写返回方法
-(void)backBtnClicked:(UIButton *)btn{
    
    [self.view endEditing:YES];
    [super backBtnClicked:btn];
}

//完成按钮的响应事件
-(void)finishBtnClicked:(UIButton *)finishBtn{
    
    [[CommodityDataManager sharedManager].dataArray addObject:self.model];
    [self.navigationController popViewControllerAnimated:YES];
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

//添加商品图片点击的响应事件
-(void)commodityImageViewTaped:(UIGestureRecognizer *)ges{

    [self showImgSelect];
}

//弹出图片选择方式
-(void)showImgSelect{
    
    UIAlertController * actionController = [UIAlertController alertControllerWithTitle:@"上传照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=sourceType;
        picker.allowsEditing = NO;
        
        
        [self  presentViewController:picker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction * pictureAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=sourceType;
        picker.allowsEditing = NO;
        
        [self  presentViewController:picker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionController addAction:takePhotoAction];
    [actionController addAction:pictureAction];
    [actionController addAction:cancleAction];
    
    
    [self presentViewController:actionController animated:YES completion:^{
        
    }];
}

#pragma mark  ----  懒加载
-(UIButton *)finishBtn{
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
        //品类标题
        UILabel * categoryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_categoryView.frame))];
        categoryTitleLabel.font = BOLDFONT14;
        categoryTitleLabel.text = @"品类:";
        [_categoryView addSubview:categoryTitleLabel];
        //品类
        UILabel * categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, SCREENWIDTH - 120, CGRectGetHeight(_categoryView.frame))];
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
        //商品标题
        UILabel * commodityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_commodityView.frame))];
        commodityTitleLabel.font = BOLDFONT14;
        commodityTitleLabel.text = @"物品:";
        [_commodityView addSubview:commodityTitleLabel];
        //商品
        UITextField * commodityTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREENWIDTH - 120, CGRectGetHeight(_commodityView.frame))];
        commodityTextField.font = FONT14;
        commodityTextField.delegate = self;
        commodityTextField.tag = UITEXTFIEDLBASETAG;
        commodityTextField.placeholder = @"请输入商品名称";
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
        UILabel * commodityImagesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, VIEWHEIGHT)];
        commodityImagesTitleLabel.font = BOLDFONT14;
        commodityImagesTitleLabel.text = @"物品图片:";
        [_commodityImageView addSubview:commodityImagesTitleLabel];
        //商品图片

        LiveWithDeleteImageView * commodityImageView = [[LiveWithDeleteImageView alloc] initWithImage:[UIImage imageNamed:@"HomeSource.bundle/photo_duf.tiff"] andFrame:CGRectMake(20, CGRectGetMaxY(commodityImagesTitleLabel.frame) + 5, 114, 69) andTarget:self andAction:@selector(commodityImageViewTaped:) andButtonTag:10 + 1];
        [_commodityImageView addSubview:commodityImageView];
        
        
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_commodityImageView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_commodityImageView addSubview:bottomLineLabel];
    }
    return _commodityImageView;
}

-(UIView *)storageLocationView{
    
    if (!_storageLocationView) {
        
        _storageLocationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commodityImageView.frame), SCREENWIDTH, VIEWHEIGHT)];
        //存放位置标题
        UILabel * storageLocationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_storageLocationView.frame))];
        storageLocationTitleLabel.font = BOLDFONT14;
        storageLocationTitleLabel.text = @"存放位置:";
        [_storageLocationView addSubview:storageLocationTitleLabel];
        //存放位置
        UITextField * storageLocationTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREENWIDTH - 120, CGRectGetHeight(_storageLocationView.frame))];
        storageLocationTextField.font = FONT14;
        storageLocationTextField.delegate = self;
        storageLocationTextField.tag = UITEXTFIEDLBASETAG + 1;
        storageLocationTextField.placeholder = @"请输入存放位置";
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
        UILabel * storageLocationImagesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, VIEWHEIGHT)];
        storageLocationImagesTitleLabel.font = BOLDFONT14;
        storageLocationImagesTitleLabel.text = @"存放位置图片:";
        [_storageLocationImageView addSubview:storageLocationImagesTitleLabel];
        //存放位置照片
        UIImageView * storageLocationImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, VIEWHEIGHT + 5, 40, 40)];
        storageLocationImage.backgroundColor = [UIColor grayColor];
        [_storageLocationImageView addSubview:storageLocationImage];
        
        UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_storageLocationImageView.frame), SCREENWIDTH, 0.5)];
        bottomLineLabel.backgroundColor = [UIColor blackColor];
        [_storageLocationImageView addSubview:bottomLineLabel];
    }
    return _storageLocationImageView;
}

-(UIView *)quantityView{
    
    if (!_quantityView) {
        
        _quantityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.storageLocationImageView.frame), SCREENWIDTH, VIEWHEIGHT)];
        //数量标题
        UILabel * numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_quantityView.frame))];
        numberTitleLabel.font = BOLDFONT14;
        numberTitleLabel.text = @"数量:";
        [_quantityView addSubview:numberTitleLabel];
        //商品数量
        UITextField * numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREENWIDTH - 120, CGRectGetHeight(_quantityView.frame))];
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
        //有无保质期标题
        UILabel * hasShelfLifeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_hasShelfLifeView.frame))];
        hasShelfLifeTitleLabel.font = BOLDFONT14;
        hasShelfLifeTitleLabel.text = @"有无保质期:";
        [_hasShelfLifeView addSubview:hasShelfLifeTitleLabel];
        
        //有无保质期开关
        UISwitch * shelfSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - 51 - 10, (40 - 31) / 2, 51, 31)];
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
        //保质期标题
        UILabel * shelfLifeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(_shelfLifeView.frame))];
        shelfLifeTitleLabel.font = BOLDFONT14;
        shelfLifeTitleLabel.text = @"保质期:";
        [_shelfLifeView addSubview:shelfLifeTitleLabel];
        //保质期
        UILabel * shelfLifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, SCREENWIDTH - 120, CGRectGetHeight(_shelfLifeView.frame))];
        shelfLifeLabel.font = FONT14;
        shelfLifeLabel.text = @"请选择物品到期时间";
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
    }
    return _model;
}

@end
