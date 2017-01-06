//
//  MainViewController.m
//  AnnotableDemo
//
//  Created by je_ffy on 2017/1/5.
//  Copyright © 2017年 je_ffy. All rights reserved.
//

#import "MainViewController.h"
#import <Photos/Photos.h>
#import "JFMainCollectionViewCell.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
static NSString *CollectionViewIdentifire = @"CollectionCell";

@interface MainViewController ()
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *assetResult;

@end

@implementation MainViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBarButtonItem];
    
    self.assetResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        NSLog(@"ScreenWidth = %f",ceil(ScreenWidth));

        NSLog(@"ScreenWidth/4 = %f",ceil(ScreenWidth/4));
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowlayout.itemSize = CGSizeMake(floor(ScreenWidth/4), floor(ScreenWidth/4));
        flowlayout.minimumLineSpacing = 0.0f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[JFMainCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewIdentifire];
        _collectionView = collectionView;
    }
    
    return _collectionView;
}

- (PHImageRequestOptions *)requestOption {
    if (!_requestOption) {
        PHImageRequestOptions *requestOption = [[PHImageRequestOptions alloc] init];
        requestOption.resizeMode = PHImageRequestOptionsResizeModeExact;//自定义图片大小的加载模式
        requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOption.synchronous = YES;//是否同步加载
        _requestOption = requestOption;
    }
    
    return _requestOption;
}

- (void)setUpBarButtonItem {
    UIBarButtonItem *leftBarButtoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(tapSettingButton)];
    UIBarButtonItem *rightBarButtoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(tapCameraButton)];
    self.navigationItem.leftBarButtonItem = leftBarButtoItem;
    self.navigationItem.rightBarButtonItem = rightBarButtoItem;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.assetResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewIdentifire forIndexPath:indexPath];
    
//    CGSizeMake(self.assetResult[indexPath.row].pixelWidth, self.assetResult[indexPath.row].pixelHeight);
//    
//    [[PHCachingImageManager defaultManager] requestImageForAsset:self.assetResult[indexPath.row] targetSize: CGSizeMake(110, 110) contentMode:PHImageContentModeDefault options:self.requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        
//        cell.photoImageView.image = result;
//
//    }];
    
    return cell;
}


#pragma mark -
#pragma mark - Action
- (void)tapSettingButton {
    
}

- (void)tapCameraButton {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.navigationController presentViewController:picker animated:YES completion:^{
            
        }];
    }
        
}
#pragma mark -
#pragma mark - UIImagePickerControllerDelegate 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
