//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "define.h"
#import "PosterModel.h"

#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

#define HIGHT self.frame.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 5.0;

@interface AdScrollView (){
//    NSMutableArray * titleArray;
    NSTimer *_autoScrollTimer;
}

@end

@implementation AdScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(0, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        self.backgroundColor = _COLOR(240, 240, 240);
    }
    
    return self;
}

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(0, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        self.backgroundColor = _COLOR(240, 240, 240);
        
         }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self setPageControlShowStyle:_PageControlShowStyle];
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setNewsmodelArray:(NSArray *)models
{
    _NewsmodelArray = models;
    if([_NewsmodelArray count] == 0){
        return;
    }
//    titleArray  =  [[NSMutableArray alloc]init];
    self.contentSize = CGSizeMake(UISCREENWIDTH * models.count,UISCREENHEIGHT);
    _pageControl.numberOfPages = [models count];
    for (int i = 0; i < models.count; i++) {
    
        //添加图片展示按钮
        PosterModel *item = [models objectAtIndex:i];
//         [titleArray addObject:item.title];
        UIButton * imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] forState:UIControlStateNormal placeholderImage:Normal_Image];
        imageView.tag = i;
        //添加点击事件
        [imageView addTarget:self action:@selector(clickPageImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageView];
        //添加标题栏
//        if (item.title.length>0) {
//           UILabel * lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(i * self.frame.size.width+5, self.frame.size.height-20.0, self.frame.size.width, 20.0)];
//            [lbltitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
//            [lbltitle setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
//
//             lbltitle.text =item.title;
//             lbltitle.backgroundColor = [UIColor clearColor];
//            [self addSubview:lbltitle];
//        }
        if (models.count>1) {
             if (!_autoScrollTimer) {
              _autoScrollTimer =[NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(switchFocusImageItems) userInfo:nil repeats:YES];
             }
//        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:chageImageTime];
        }
    }
}

- (void) clickPageImage:(UIButton*)sender
{
    PosterModel *model = [self.NewsmodelArray objectAtIndex:sender.tag];
    if(model.isRedirect == 1){
        WebViewController *vc = [IBUIFactory CreateWebViewController];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = model.title;
        vc.type = enumShareTypeShare;
        if(model.imgUrl != nil)
            vc.shareImgArray = [NSArray arrayWithObject:model.imgUrl];
        vc.shareTitle = model.title;
        [_parentController.navigationController pushViewController:vc animated:YES];
        if(model.url == nil){
            [vc loadHtmlFromUrlWithUserId:[NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", model.pid]];
        }else{
            [vc loadHtmlFromUrlWithUserId:model.url];
        }
    }
}

- (void)switchFocusImageItems
{
   // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = self.contentOffset.x + self.frame.size.width;
    [self moveToTargetPosition:targetX];
    
  //  [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:chageImageTime];
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
  //  NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= self.contentSize.width) {
        targetX = 0.0;
    }
    
    [self setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    _pageControl.currentPage = (int)(self.contentOffset.x / self.frame.size.width);
}


#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    _PageControlShowStyle = PageControlShowStyle;
    
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _NewsmodelArray.count;
        _pageControl.currentPage = 0;
    }else{
        _pageControl.numberOfPages = _NewsmodelArray.count;
    }
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [_pageControl removeFromSuperview];
    [[self superview] addSubview:_pageControl];
}


//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndDecelerating");
    //手动滑动时候暂停自动替换
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    _autoScrollTimer =[NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(switchFocusImageItems) userInfo:nil repeats:YES];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

@end


