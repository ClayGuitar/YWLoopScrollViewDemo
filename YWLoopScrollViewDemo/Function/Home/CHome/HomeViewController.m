//
//  HomeViewController.m
//  YWLoopScrollViewDemo
//
//  Created by 王亚文 on 2017/4/14.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "HomeViewController.h"
#import "YWLoopScrollView.h"


@interface HomeViewController ()<YWLoopScrollViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"YWLoopScrollView";
    self.titleView.backgroundColor = RGB(31, 162, 252);
    
    NSArray *imagesArr = @[IMAGE(@"img01.jpeg"),IMAGE(@"img02.jpeg"),IMAGE(@"img03.jpeg"), IMAGE(@"img04.jpeg")]; // ,IMAGE(@"img05.jpeg")
    YWLoopScrollView *loopScrollView = [[YWLoopScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, 250) images:imagesArr];
    loopScrollView.scrollInterval = 2.f;
    loopScrollView.isAutoScroll = YES;  // default is YES
    loopScrollView.delegate = self;
    [self.contentView addSubview:loopScrollView];
}

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView currentPageIndex:(NSInteger)index
{
    NSLog(@"❤：currentPageIndex is %d", (int)index);
}

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView didSelectedPageIndex:(NSInteger)index
{
    NSLog(@"❤：didSelectedPageIndex is %d", (int)index);
}

@end
