//
//  JFEditImageViewController.m
//  AnnotableDemo
//
//  Created by je_ffy on 2017/1/7.
//  Copyright © 2017年 je_ffy. All rights reserved.
//

#import "JFEditImageViewController.h"

@interface JFEditImageViewController ()

@property (nonatomic, strong) UIButton *closeCurrentVCButton;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;


@end

@implementation JFEditImageViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.closeCurrentVCButton];
    [self.view addSubview:self.actionButton];

    
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark - Lazy Load
- (UIButton *)closeCurrentVCButton {
    if (!_closeCurrentVCButton) {
        UIButton *closeCurrentVCButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        closeCurrentVCButton.layer.borderWidth = 0.50f;
        closeCurrentVCButton.layer.borderColor = [UIColor redColor].CGColor;
        [closeCurrentVCButton addTarget:self action:@selector(closeCurrentVC) forControlEvents:UIControlEventTouchUpInside];
        [closeCurrentVCButton setImage:[UIImage imageNamed:@"sp_web_close"] forState:UIControlStateNormal];
        _closeCurrentVCButton = closeCurrentVCButton;
    }
    
    return _closeCurrentVCButton;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 44, 20, 44, 44)];
        actionButton.layer.borderWidth = 0.50f;
        actionButton.layer.borderColor = [UIColor redColor].CGColor;
        [actionButton addTarget:self action:@selector(actionButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [actionButton setImage:[UIImage imageNamed:@"list_share_img"] forState:UIControlStateNormal];
        _actionButton = actionButton;
    }
    
    return _actionButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        imageView.layer.borderWidth = 0.50f;
        imageView.layer.borderColor = [UIColor redColor].CGColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView = imageView];
    }
    
    return _imageView;
}

- (PHImageRequestOptions *)requestOption {
    if (!_requestOption) {
        PHImageRequestOptions *requestOption = [[PHImageRequestOptions alloc] init];
        requestOption.resizeMode = PHImageRequestOptionsResizeModeExact;//自定义图片大小的加载模式
        requestOption.version = PHImageRequestOptionsVersionOriginal;
        requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOption.synchronous = YES;//是否同步加载
        _requestOption = requestOption;
    }
    
    return _requestOption;
}


#pragma mark -
#pragma mark - Setter Method
- (void)setPhAsset:(PHAsset *)phAsset {
    _phAsset = phAsset;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:_phAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:self.requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        self.imageView.image = result;
        
    }];
    
}

#pragma mark -
#pragma mark - Action
- (void)closeCurrentVC {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)actionButtonTap {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
