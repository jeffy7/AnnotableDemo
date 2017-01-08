//
//  MainViewController.m
//  AnnotableDemo
//
//  Created by je_ffy on 2017/1/5.
//  Copyright © 2017年 je_ffy. All rights reserved.
//

#import "MainViewController.h"
#import "JFMainCollectionViewCell.h"
#import "JFEditImageViewController.h"

static NSString *CollectionViewIdentifire = @"CollectionCell";
static CGFloat CELL_LINE_MAGIN = 1.0f;

@interface MainViewController ()
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *assetResult;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MainViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBarButtonItem];
    self.dataArray = [[NSMutableArray alloc] init];
    [self setUpDataArray];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
}

- (void)setUpDataArray {
    NSLog(@"startTime =");
    __block NSMutableArray *tarDataArray= [NSMutableArray array];

    self.assetResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];

    [self.assetResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tarDataArray addObject:obj];
    }];
    
    NSArray *tarReverseArray = [NSArray arrayWithArray:tarDataArray];
    _dataArray = (NSMutableArray *)[[tarReverseArray reverseObjectEnumerator] allObjects];
    NSLog(@"endTime =");
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat cellW = (self.view.frame.size.width - 1*3 ) / 4;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 1.0f;
        layout.minimumLineSpacing = CELL_LINE_MAGIN;

        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
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
        requestOption.version = PHImageRequestOptionsVersionOriginal;
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
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewIdentifire forIndexPath:indexPath];
    
    CGSizeMake(self.assetResult[indexPath.row].pixelWidth, self.assetResult[indexPath.row].pixelHeight);
    CGFloat cellW = (self.view.frame.size.width - 1*3 ) / 4;

    [[PHCachingImageManager defaultManager] requestImageForAsset:_dataArray[indexPath.row] targetSize: CGSizeMake(cellW*2, cellW*2) contentMode:PHImageContentModeAspectFill options:self.requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        cell.photoImageView.image = result;

    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JFEditImageViewController *editImageViewController = [[JFEditImageViewController alloc] init];
    editImageViewController.phAsset = _dataArray[indexPath.row];
    [self presentViewController:editImageViewController animated:YES completion:^{
        
    }];
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
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }];
        
    }
}


- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    
    if (!error) {
        
        [self performSelector:@selector(refreshdata) withObject:nil afterDelay:0.3f];
    }
    
}

- (void)refreshdata {
    [self setUpDataArray];
    [self.collectionView reloadData];
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
