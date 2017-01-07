//
//  JFMainCollectionViewCell.m
//  AnnotableDemo
//
//  Created by je_ffy on 2017/1/6.
//  Copyright © 2017年 je_ffy. All rights reserved.
//

#import "JFMainCollectionViewCell.h"

@implementation JFMainCollectionViewCell

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.50f;
        self.layer.borderColor = [UIColor redColor].CGColor;

        [self addSubview:self.photoImageView];
    }
    
    return self;
}

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        photoImageView.contentMode = UIViewContentModeScaleToFill;
        _photoImageView = photoImageView;
    }
    
    return _photoImageView;
}

@end
