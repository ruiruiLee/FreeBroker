//
//  PhotoBrowserView.m
//  SPH0
//
//  Created by NEW on 15/12/14.
//  Copyright © 2015年 SPH. All rights reserved.
//

#import "PhotoBrowserView.h"

#import "PhotoBrowserScrollView.h"
#import "define.h"


@interface PhotoBrowserView ()<UIScrollViewDelegate>

//导航条
@property (nonatomic,strong) UIView *backNavigationView;

@property (nonatomic,strong) NSArray *urlArray;

@property (nonatomic,assign) int currentIndex;


//计数板
@property (nonatomic,strong) UILabel *numberLabel;


@end



@implementation PhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array andCurrentIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bgview = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:bgview];
        bgview.backgroundColor = [UIColor blackColor];
        bgview.alpha = 0.4;
        
        if(array.count!=0&&array!=nil)
        {
            _urlArray = array;
            if(_currentIndex>array.count){
                _currentIndex = 0;
            }
            self.userInteractionEnabled = YES;
            [self createNavigationView];
            
            [self createScrollView];
            
            [self bringSubviewToFront:_backNavigationView];
            
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}


/**
 * 创建导航条View
 */

-(void)createNavigationView
{
    
    //背景View
    _backNavigationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    _backNavigationView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_backNavigationView];
    
    //backButton
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backNavigationView addSubview:backButton];
    
    //label
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _numberLabel.center = CGPointMake(_backNavigationView.center.x, _backNavigationView.center.y+5);
        _numberLabel.text=[NSString stringWithFormat:@"%d/%ld",_currentIndex+1,_urlArray.count];
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        [_backNavigationView addSubview:_numberLabel];
    
    
}

-(void)createScrollView
{
    PhotoBrowserScrollView *allScreeenSV=[[PhotoBrowserScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.bounds.size.height)];
    allScreeenSV.currenIndex = _currentIndex;

    allScreeenSV.arrayUrl = _urlArray;
    allScreeenSV.tag  = 100;
    allScreeenSV.delegate  = self;
    __weak PhotoBrowserView *BlockSelf =self;
    allScreeenSV.imageClickBlock  = ^{
//            if(BlockSelf.backNavigationView.hidden==YES){
//                BlockSelf.backNavigationView.hidden=NO;
//            }
//            else
//            {
//                BlockSelf.backNavigationView.hidden=YES;
//            }
        
        [self removeFromSuperview];
    };
    
    allScreeenSV.zoomChange = ^(CGFloat zoom){
        
//        if(zoom<1){
//        self.backNavigationView.hidden  =YES;
//        }else{
//            self.backNavigationView.hidden  =NO;
//
//        }
//        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:zoom/3];

    };

    [self addSubview:allScreeenSV];
}

-(void)backButtonClick:(UIButton *)button
{
    [self removeFromSuperview];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.tag == 100){
        int index = scrollView.contentOffset.x/scrollView.frame.size.width;
            _numberLabel.text = [NSString stringWithFormat:@"%d/%ld",(index+1),_urlArray.count];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIView *tempView in scrollView.subviews) {
        if([tempView isKindOfClass:[UIScrollView class]]){
            UIScrollView *sv= (UIScrollView *)tempView;
//            sv.zoomScale = 1.0;
            [sv setZoomScale:1.0 animated:YES];
        }
    }
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com