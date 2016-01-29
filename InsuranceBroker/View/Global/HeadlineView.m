//
//  HeadlineView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/15.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "HeadlineView.h"
#import "define.h"

//实际cell 视图的数量
#define default_Item_count 2

@interface HeadlineCell ()

@end

@implementation HeadlineCell
@synthesize indexPath;
@synthesize lbDetail;
//@synthesize lbTitle;

+ (id) loadFromNib
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeadlineCell" owner:self options:nil];
    
    UIView *tmpView = [nib objectAtIndex:0];
    
    return tmpView;
}

- (IBAction) doBtnButtonClicked:(UIButton *)sender
{
    if(self.pView){
        if(self.pView.delegate && [self.pView.delegate respondsToSelector:@selector(headline:SelectAtIndexPath:)]){
            [self.pView.delegate headline:self.pView SelectAtIndexPath:self.indexPath];
        }
    }
}

@end

/////// view  ////
//////////////////
@interface HeadlineView ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation HeadlineView
@synthesize timer;
@synthesize cellArray;
@synthesize scrollview;
@synthesize delegate;
@synthesize imgTitle;
@synthesize lbSepLine;

- (void) dealloc
{
    [timer invalidate];
    timer = nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.clipsToBounds = YES;
        self.offset = 0;
        
        cellArray = [[NSMutableArray alloc] init];
        
        scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollview];
        
        lbSepLine = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:[UIColor clearColor]];
        lbSepLine.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
        [self addSubview:lbSepLine];
        
        imgTitle = [[UIImageView alloc] initWithImage:ThemeImage(@"hot")];
        [self addSubview:imgTitle];
        
//        view = [[UIView alloc] initWithFrame:CGRectZero];
//        [self addSubview:view];
        
        scrollview.pagingEnabled = YES;
        scrollview.scrollEnabled = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.clipsToBounds = YES;
        self.offset = 0;
        
        cellArray = [[NSMutableArray alloc] init];
        
        scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollview];
        scrollview.pagingEnabled = YES;
        scrollview.scrollEnabled = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.showsVerticalScrollIndicator = NO;
        
        lbSepLine = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:[UIColor clearColor]];
        lbSepLine.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
        [self addSubview:lbSepLine];
        
        imgTitle = [[UIImageView alloc] initWithImage:ThemeImage(@"hot")];
        [self addSubview:imgTitle];
        
        view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGSize imgSize = imgTitle.image.size;
    
    view.frame = self.bounds;
    imgTitle.frame = CGRectMake(10, (frame.size.height - imgSize.height)/2, imgSize.width, imgSize.height);
    lbSepLine.frame = CGRectMake(20 + imgSize.width, 6, 0.7, frame.size.height - 12);
    scrollview.frame = CGRectMake(30 + imgSize.width, 0, self.frame.size.width - 30 - imgSize.width, self.frame.size.height);
    [self reset];
}

- (void) reloadData
{
    if(delegate){
        if([delegate numberOfRows:self] > 0)
            [self initialize];
    }
}

- (void) initialize
{
    for (int i = 0; i < [cellArray count]; i++) {
        HeadlineCell *cell = [cellArray objectAtIndex:i];
        
        [cell removeFromSuperview];
    }
    [cellArray removeAllObjects];
    
    for (int i = 0; i < default_Item_count; i++) {
        HeadlineCell *cell = [HeadlineCell loadFromNib];
        cell.pView = self;
        [scrollview addSubview:cell];
        
        [cellArray addObject:cell];
        cell.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if(delegate){
            NSInteger count = [delegate numberOfRows:self];
            
            int idx = i;
            
            while (idx >= count) {
                idx = idx - count;
            }
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:idx inSection:0];
            [delegate headline:cell cellForRowAtIndexPath:indexpath];
            cell.indexPath = indexpath;
        }
    }
    
    [self reset];
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width, 40 * default_Item_count);
    if([cellArray count] > 1)
        [self performSelector:@selector(startTimer) withObject:nil afterDelay:2.0];
}

- (void) startTimer
{
    if(timer){
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAfterTimer) userInfo:nil repeats:YES];
    [timer fire];
}

- (void) reset
{

    CGFloat oy = 0;
    
    for (int i = 0; i < [cellArray count]; i++) {
        HeadlineCell *cell = [cellArray objectAtIndex:i];
        
        cell.frame = CGRectMake(0, oy, scrollview.frame.size.width, self.frame.size.height);
        
        oy += self.frame.size.height;
    }
    
//    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width, self.frame.size.height * 2);
}

#pragma Action

- (void) timerAfterTimer
{
    
    CGRect frame = scrollview.frame;
    
    [scrollview scrollRectToVisible:CGRectMake(0, frame.size.height, frame.size.width, frame.size.height) animated:YES];
    [self performSelector:@selector(doAfterScroll) withObject:nil afterDelay:0.25];
}

- (void) doAfterScroll
{
    CGFloat offset = self.offset;
    
    self.offset = scrollview.contentOffset.y;
    
    if(scrollview.contentOffset.y > offset){
        //向上滑
        if(scrollview.contentOffset.y >= scrollview.frame.size.height){
            HeadlineCell *cell = [cellArray firstObject];
            [cellArray removeObjectAtIndex:0];
            [cellArray addObject:cell];
            
            if(delegate){
                NSInteger count = [delegate numberOfRows:self];
                NSIndexPath *old = cell.indexPath;
                NSInteger new = old.row + default_Item_count;
                
                while (new >= count) {
                    new = new - count;
                }
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:new inSection:0];
                [delegate headline:cell cellForRowAtIndexPath:indexpath];
                cell.indexPath = indexpath;
            }
            
            scrollview.contentOffset = CGPointMake(scrollview.contentOffset.x, scrollview.contentOffset.y - scrollview.frame.size.height);


            self.offset = scrollview.contentOffset.y;
            [self reset];
        }
    }
}

@end
