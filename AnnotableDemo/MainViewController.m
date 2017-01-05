//
//  MainViewController.m
//  AnnotableDemo
//
//  Created by je_ffy on 2017/1/5.
//  Copyright © 2017年 je_ffy. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MainViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBarButtonItem];
    
}

- (void)setUpBarButtonItem {
    UIBarButtonItem *leftBarButtoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(tapSettingButton)];
    UIBarButtonItem *rightBarButtoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(tapCameraButton)];
    self.navigationItem.leftBarButtonItem = leftBarButtoItem;
    self.navigationItem.rightBarButtonItem = rightBarButtoItem;
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
