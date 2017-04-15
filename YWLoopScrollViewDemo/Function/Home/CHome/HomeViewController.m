//
//  HomeViewController.m
//  YWLoopScrollViewDemo
//
//  Created by 王亚文 on 2017/4/14.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "HomeViewController.h"
#import "YWLoopScrollView.h"
#import "SecondViewController.h"

#define Scr_H 250.f

@interface HomeViewController ()<YWLoopScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView            *tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"YWLoopScrollView";
    self.titleView.backgroundColor = RGB(31, 162, 252);
    
    _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(Scr_H, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, -Scr_H);
    [self.contentView addSubview:_tableView];
    
    NSArray *imagesArr = @[IMAGE(@"img01.jpeg"),IMAGE(@"img02.jpeg"),IMAGE(@"img03.jpeg"), IMAGE(@"img04.jpeg"),IMAGE(@"img05.jpeg")];
    YWLoopScrollView *loopScrollView = [[YWLoopScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Scr_H) images:imagesArr];
    loopScrollView.scrollInterval = 3.5f;
    loopScrollView.isAutoScroll = YES;  // default is YES
    loopScrollView.delegate = self;
    [self.contentView addSubview:loopScrollView];
}

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView currentPageIndex:(NSInteger)index image:(id)image
{
    NSLog(@"❤：currentPageIndex is %d", (int)index);
}

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView didSelectedPageIndex:(NSInteger)index image:(id)image
{
    NSLog(@"❤：didSelectedPageIndex is %d", (int)index);
    SecondViewController *secondVC = [SecondViewController new];
    secondVC.image = image;
    [self.navigationController pushViewController:secondVC animated:YES];
}



#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"wang%d", (int)indexPath.row];
    return cell;
}


@end
