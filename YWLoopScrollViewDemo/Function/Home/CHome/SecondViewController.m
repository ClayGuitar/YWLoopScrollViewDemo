//
//  SecondViewController.m
//  YWLoopScrollViewDemo
//
//  Created by 王亚文 on 2017/4/15.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong)UIImageView        *imgView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"SecondViewController";
    
    _imgView = [UIImageView create];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.image = _image;
    [self.contentView addSubview:_imgView];
    LAY(_imgView.centerX, self.contentView.centerX, 1, 0);
    LAY(_imgView.centerY, self.contentView.centerY, 1, 0);
    LAYC(_imgView.width, Width_MainScreen);
    LAYC(_imgView.height, 250.f);
}

@end
