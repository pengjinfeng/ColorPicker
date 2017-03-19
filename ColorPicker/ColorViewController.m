/*
 #####################################################################
 # File    : ColorViewController.m
 # Project :
 # Created : 17/3/19
 # DevTeam : Development Team
 # Author  : jinfeng.peng
 # Notes   :
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 #
 #####################################################################
 */
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define colorMovePickerLength 10.0f
#import "ColorViewController.h"
#import "ColorPickManageTools.h"
#import "CameraManageTools.h"
const CGFloat padding = 10.0f;
const CGFloat top = 100.0f;
const CGFloat bottom = 30.0f;
const CGFloat labelW = 50.0f;

@interface ColorViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImage *pickImage;
}
//展示图片的image
@property(nonatomic,strong)UIImageView *pickerImageView;
//显示主色label
@property(nonatomic,strong)UILabel *mainColorLabel;
//相册选取照片
@property(nonatomic,strong)UIButton *chooseImageButton;
//滑块图片
@property(nonatomic,strong)UIImageView *colorMovePicker;
//检测截取的图片
@property(nonatomic,strong)UIImageView *checkImageView;
@end
@implementation ColorViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.pickerImageView];
    [self.view addSubview:self.mainColorLabel];
    [self.view addSubview:self.chooseImageButton];
    [self.pickerImageView addSubview:self.colorMovePicker];
    [self.view addSubview:self.checkImageView];
}
/* 打开相册，选取照片 */
- (void)chooseImageButton:(UIButton *)sender{
    [CameraManageTools openImagePickController:self];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    pickImage = info[@"UIImagePickerControllerOriginalImage"];
    [self.pickerImageView setImage:pickImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.colorMovePicker.hidden = NO;
}

//滑块边界设置
- (BOOL)locationView:(CGPoint)location{
    if (location.x >= colorMovePickerLength/2 && location.x <= self.pickerImageView.bounds.size.width - colorMovePickerLength/2 && location.y >= colorMovePickerLength/2 && location.y <= self.pickerImageView.bounds.size.height - colorMovePickerLength/2 && self.pickerImageView.image != nil) {
        return YES;
    }else{
        return NO;
    }
}
//获取主色
- (UIColor *)mainColorWithLocation:(CGPoint)location{
    UIColor *mainColor;
    if([self locationView:location]){
        self.colorMovePicker.center = location;
        CGRect cutRect = CGRectMake(location.x - colorMovePickerLength/2.0, location.y - colorMovePickerLength/2.0, colorMovePickerLength, colorMovePickerLength);
        UIImage *originImage = [ColorPickManageTools scaleToSize:self.pickerImageView.image size:self.pickerImageView.bounds.size];
        UIImage *cutImage = [ColorPickManageTools imageFromImage:originImage inRect:cutRect];
        self.checkImageView.image = cutImage;
        NSDictionary  *dic = [ColorPickManageTools mostColor:cutImage scale:1.0];
        CGFloat red, green, blue;
        red = [dic[@"red"] floatValue];
        green = [dic[@"green"] floatValue];
        blue = [dic[@"blue"] floatValue];
        mainColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    return mainColor;
}
/* 通过手势获取截取图片的主色 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self.pickerImageView];
    self.mainColorLabel.backgroundColor = [self mainColorWithLocation:location];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self.pickerImageView];
    self.mainColorLabel.backgroundColor = [self mainColorWithLocation:location];
}



#pragma mark -- UI视图初始化
- (UIImageView *)pickerImageView{
    if (!_pickerImageView) {
        _pickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, top, kScreenW - padding * 2, kScreenW - padding * 2)];
        _pickerImageView.backgroundColor = [UIColor blackColor];
        _pickerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pickerImageView;
}
- (UILabel *)mainColorLabel{
    if (!_mainColorLabel) {
        _mainColorLabel = [[UILabel alloc] init];
        _mainColorLabel.center = CGPointMake(kScreenW/2, self.pickerImageView.frame.origin.y + self.pickerImageView.frame.size.height + labelW + bottom);
        _mainColorLabel.bounds = CGRectMake(0, 0, labelW, labelW);
        _mainColorLabel.backgroundColor = [UIColor blackColor];
    }
    return _mainColorLabel;
}
- (UIButton *)chooseImageButton{
    if (!_chooseImageButton) {
        _chooseImageButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_chooseImageButton setTitle:@" pick Image " forState:UIControlStateNormal];
        [_chooseImageButton sizeToFit];
        _chooseImageButton.center = CGPointMake(kScreenW/2, bottom + _chooseImageButton.bounds.size.height/2);
        _chooseImageButton.layer.cornerRadius = 3.0f;
        _chooseImageButton.layer.borderWidth = 1.0f;
        _chooseImageButton.layer.borderColor = [UIColor orangeColor].CGColor;
        [_chooseImageButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_chooseImageButton addTarget:self action:@selector(chooseImageButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseImageButton;
}
- (UIImageView *)colorMovePicker{
    if (!_colorMovePicker) {
        _colorMovePicker = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _colorMovePicker.image = [UIImage imageNamed:@"photo_gb"];
        self.colorMovePicker.hidden = YES;
    }
    return _colorMovePicker;
}
- (UIImageView *)checkImageView{
    if (!_checkImageView) {
        _checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 10, 10)];
        _checkImageView.backgroundColor = [UIColor blackColor];
    }
    return _checkImageView;
}
@end
