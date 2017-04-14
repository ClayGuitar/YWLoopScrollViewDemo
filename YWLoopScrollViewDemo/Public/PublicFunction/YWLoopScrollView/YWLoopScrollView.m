//
//  YWLoopScrollView.m
//  YWLoopScrollViewDemo
//
//  Created by 王亚文 on 2017/4/14.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "YWLoopScrollView.h"

static NSString *loopCellId = @"loopCellId";

@interface YWCollectionCell ()

@property (nonatomic, strong)UIImageView        *imgView;

@end

@implementation YWCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _imgView = [UIImageView create];
//        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        LAY(_imgView.left, self.left, 1, 0);
        LAY(_imgView.right, self.right, 1, 0);
        LAY(_imgView.top, self.top, 1, 0);
        LAY(_imgView.bottom, self.bottom, 1, 0);

        self.backgroundColor = Color_Random;
    }
    return self;
}

- (void)refreshContent:(UIImage *)image
{
    [self clearCellData];
    _imgView.image = image;
}

- (void)clearCellData
{
    _imgView.image = nil;
}

@end



@interface YWLoopScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView           *collecionView;
@property (nonatomic, strong)UIPageControl              *pageControl;
@property (nonatomic, strong)NSArray                    *imagesArr;
@property (nonatomic, strong)NSTimer                    *timer;

@end

@implementation YWLoopScrollView


- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _imagesArr = [NSArray arrayWithArray:images];
        _pageControlDefaultColor = [UIColor whiteColor];
        _pageControlSelectedColor = [UIColor orangeColor];
        _scrollInterval = 2.f;
        _pageControlRect = CGRectMake(0, CGRectGetHeight(frame)-40.f, CGRectGetWidth(frame), 40.f);
        _isAutoScroll = YES;
        self.backgroundColor = [UIColor grayColor];
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        _collecionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collecionView.delegate = self;
        _collecionView.dataSource = self;
        _collecionView.pagingEnabled = YES;
        _collecionView.showsVerticalScrollIndicator = NO;
        _collecionView.showsHorizontalScrollIndicator = NO;
        _collecionView.backgroundColor = [UIColor whiteColor];
        [_collecionView registerClass:[YWCollectionCell class] forCellWithReuseIdentifier:loopCellId];
        _collecionView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0);
        [self addSubview:_collecionView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:_pageControlRect];
        _pageControl.pageIndicatorTintColor = _pageControlDefaultColor;
        _pageControl.currentPageIndicatorTintColor = _pageControlSelectedColor;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = _imagesArr.count;
        [self addSubview:_pageControl];
        
    
        if(_isAutoScroll){
          [self startAutoScroll];
        }
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imagesUrl:(NSArray *)imagesUrl
{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _pageControl.frame = _pageControlRect;
}

- (void)startAutoScroll
{
    [self stopAutoScroll];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

- (void)stopAutoScroll
{
    if(_timer){
        [_timer invalidate];
    }
}

- (void)nextPage
{
    if(_imagesArr.count==0||_imagesArr.count==1){
        return;
    }
    
    CGPoint offset = _collecionView.contentOffset;
    NSIndexPath *indexPath = [_collecionView indexPathForItemAtPoint:offset];

    [_collecionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row+1 inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}



#pragma mark - collection datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesArr.count+2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YWCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:loopCellId forIndexPath:indexPath];
    NSInteger index = [self imageIndexFromRowIndex:indexPath.row];
    [cell refreshContent:_imagesArr[index]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(ywLoopScrollView:didSelectedPageIndex:)]){
        [self.delegate ywLoopScrollView:self didSelectedPageIndex:indexPath.row];
    }
}

#pragma mark - flowlayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollRefresh];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollRefresh];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAutoScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    if(!decelerate){
//        [self startAutoScroll];
//    }
    [self startAutoScroll];
}


#pragma mark - 循环轮播的核心逻辑
- (void)scrollRefresh
{
    NSInteger dataIndex = floor(_collecionView.contentOffset.x/CGRectGetWidth(self.frame));
    NSIndexPath *indexPath = [_collecionView indexPathForItemAtPoint:_collecionView.contentOffset];
    NSInteger currentPage = [self imageIndexFromRowIndex:indexPath.row];
    
    if(dataIndex==0){
        [_collecionView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame)*_imagesArr.count, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:NO];
        _pageControl.currentPage = _imagesArr.count-1;
    }
    else if(dataIndex==_imagesArr.count+1){
        [_collecionView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:NO];
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = currentPage;
    }
    
    NSLog(@"---❤%d---",(int)dataIndex);
    
    // callback
    if([self.delegate respondsToSelector:@selector(ywLoopScrollView:currentPageIndex:)]){
        [self.delegate ywLoopScrollView:self currentPageIndex:currentPage];
    }
}

- (NSInteger)imageIndexFromRowIndex:(NSInteger)rowIndex
{
    if(rowIndex==0){
        return self.imagesArr.count-1;
    }else if(rowIndex==self.imagesArr.count+1){
        return 0;
    }else{
        return rowIndex-1;
    }
}


#pragma mark - setter/getter

- (void)setPageControlDefaultColor:(UIColor *)pageControlDefaultColor
{
    _pageControlDefaultColor = pageControlDefaultColor;
    _pageControl.pageIndicatorTintColor = _pageControlDefaultColor;
}

- (void)setPageControlSelectedColor:(UIColor *)pageControlSelectedColor
{
    _pageControlSelectedColor = pageControlSelectedColor;
    _pageControl.currentPageIndicatorTintColor = _pageControlSelectedColor;
}

- (void)setScrollInterval:(CGFloat)scrollInterval
{
    _scrollInterval = scrollInterval;
    [self startAutoScroll];
}

- (void)setPageControlRect:(CGRect)pageControlRect
{
    _pageControlRect = pageControlRect;
    [self setNeedsLayout];
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    if(_isAutoScroll){
        [self startAutoScroll];
    }else{
        [self stopAutoScroll];
    }
}

- (void)dealloc
{
    [self stopAutoScroll];
}



@end



