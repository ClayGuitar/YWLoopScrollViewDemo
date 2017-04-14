//
//  YWLoopScrollView.h
//  YWLoopScrollViewDemo
//
//  Created by 王亚文 on 2017/4/14.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YWLoopScrollView;
@protocol YWLoopScrollViewDelegate <NSObject>

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView currentPageIndex:(NSInteger)index;

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView didSelectedPageIndex:(NSInteger)index;

@end

@interface YWLoopScrollView : UIView

@property (nonatomic, strong)UIColor        *pageControlDefaultColor;

@property (nonatomic, strong)UIColor        *pageControlSelectedColor;

@property (nonatomic, assign)CGFloat         scrollInterval;

@property (nonatomic, assign)CGRect          pageControlRect;

@property (nonatomic, assign)BOOL            isAutoScroll;

@property (nonatomic, weak)id<YWLoopScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

//- (instancetype)initWithFrame:(CGRect)frame imagesUrl:(NSArray *)imagesUrl;

@end



@interface YWCollectionCell : UICollectionViewCell

@end
