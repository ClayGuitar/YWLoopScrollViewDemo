# YWLoopScrollViewDemo

#### 效果：

![loop.gif](http://upload-images.jianshu.io/upload_images/988593-ebf7651d20722d68.gif?imageMogr2/auto-orient/strip)


#### 使用：
```
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

#pragma mark - YWLoopScrollViewDelegate
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

```

#### YWLoopScrollView.h接口：

```
#import <UIKit/UIKit.h>

@class YWLoopScrollView;
@protocol YWLoopScrollViewDelegate <NSObject>

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView currentPageIndex:(NSInteger)index;

- (void)ywLoopScrollView:(YWLoopScrollView *)scrollView didSelectedPageIndex:(NSInteger)index;

@end

@interface YWLoopScrollView : UIView

@property (nonatomic, strong)UIColor        *pageControlDefaultColor; // pageControl的默认颜色

@property (nonatomic, strong)UIColor        *pageControlSelectedColor; // pageControl当前点的颜色

@property (nonatomic, assign)CGFloat         scrollInterval; // 滚动时间

@property (nonatomic, assign)CGRect          pageControlRect; // pageControl的frame

@property (nonatomic, assign)BOOL            isAutoScroll; // 是否自动滚动

@property (nonatomic, weak)id<YWLoopScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

//- (instancetype)initWithFrame:(CGRect)frame imagesUrl:(NSArray *)imagesUrl;

@end
```


