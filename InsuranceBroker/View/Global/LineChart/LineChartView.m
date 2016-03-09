//
//  LineChartView.m
//  
//
//  Created by Marcel Ruegenberg on 02.08.13.
//
//

#import "LineChartView.h"
#import "LegendView.h"
#import "InfoView.h"
#import "NSArray+FPAdditions.h"
#import "define.h"

@interface LineChartDataItem ()

@property (readwrite) float x; // should be within the x range
@property (readwrite) float y; // should be within the y range
@property (readwrite) NSString *xLabel; // label to be shown on the x axis
@property (readwrite) NSString *dataLabel; // label to be shown directly at the data item
@property (readwrite) NSString *detail;

- (id)initWithhX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel detail:(NSString*)detail;

@end

@implementation LineChartDataItem

- (id)initWithhX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel  detail:(NSString*)detail{
    if((self = [super init])) {
        self.x = x;
        self.y = y;
        self.xLabel = xLabel;
        self.dataLabel = dataLabel;
        self.detail = detail;
    }
    return self;
}

+ (LineChartDataItem *)dataItemWithX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel  detail:(NSString*)detail{
    return [[LineChartDataItem alloc] initWithhX:x y:y xLabel:xLabel dataLabel:dataLabel detail:detail];
}

@end



@implementation LineChartData

@end



@interface LineChartView ()

//@property LegendView *legendView;
@property InfoView *infoView;
@property UIView *currentPosView;
@property UILabel *xAxisLabel;

- (BOOL)drawsAnyData;

@end


#define X_AXIS_SPACE 15
#define PADDING 10


@implementation LineChartView
@synthesize data=_data;
@synthesize xDisplacement;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        xDisplacement = 0.0;
        
        self.currentPosView = [[UIView alloc] initWithFrame:CGRectMake(PADDING, PADDING, 1 / self.contentScaleFactor, 50)];
        self.currentPosView.backgroundColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
        self.currentPosView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.currentPosView.alpha = 0.0;
        [self addSubview:self.currentPosView];
        
        //        self.legendView = [[LegendView alloc] initWithFrame:CGRectMake(frame.size.width - 50 - 10, 10, 50, 30)];
        //        self.legendView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        //        self.legendView.backgroundColor = [UIColor clearColor];
        //        [self addSubview:self.legendView];
        
        self.xAxisLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        self.xAxisLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.xAxisLabel.font = [UIFont boldSystemFontOfSize:10];
        self.xAxisLabel.textColor = [UIColor grayColor];
        self.xAxisLabel.textAlignment = NSTextAlignmentCenter;
        self.xAxisLabel.alpha = 0.0;
        self.xAxisLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.xAxisLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        self.scaleFont = [UIFont systemFontOfSize:12.0];
        
        self.autoresizesSubviews = YES;
        self.contentMode = UIViewContentModeRedraw;
        
        self.drawsDataPoints = YES;
        self.drawsDataLines  = YES;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        
        xDisplacement = 0.0;
        
        self.currentPosView = [[UIView alloc] initWithFrame:CGRectMake(PADDING, PADDING, 1 / self.contentScaleFactor, 50)];
        self.currentPosView.backgroundColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
        self.currentPosView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.currentPosView.alpha = 0.0;
        [self addSubview:self.currentPosView];
        
//        self.legendView = [[LegendView alloc] initWithFrame:CGRectMake(frame.size.width - 50 - 10, 10, 50, 30)];
//        self.legendView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
//        self.legendView.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.legendView];
        
        self.xAxisLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        self.xAxisLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.xAxisLabel.font = [UIFont boldSystemFontOfSize:10];
        self.xAxisLabel.textColor = [UIColor grayColor];
        self.xAxisLabel.textAlignment = NSTextAlignmentCenter;
        self.xAxisLabel.alpha = 0.0;
        self.xAxisLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.xAxisLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        self.scaleFont = [UIFont systemFontOfSize:12.0];
        
        self.autoresizesSubviews = YES;
        self.contentMode = UIViewContentModeRedraw;

        self.drawsDataPoints = YES;
        self.drawsDataLines  = YES;
    }
    return self;
}

- (void)showLegend:(BOOL)show animated:(BOOL)animated {
//    if(! animated) {
//        self.legendView.alpha = show ? 1.0 : 0.0;
//        return;
//    }
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.legendView.alpha = show ? 1.0 : 0.0;
//    }];
}
                           
- (void)layoutSubviews {
//    [self.legendView sizeToFit];
//    CGRect r = self.legendView.frame;
//    r.origin.x = self.frame.size.width - self.legendView.frame.size.width - 3 - PADDING;
//    r.origin.y = 3 + PADDING;
//    self.legendView.frame = r;
//    
    CGRect r = self.currentPosView.frame;
    CGFloat h = self.frame.size.height;
    r.size.height = h - 2 * PADDING - X_AXIS_SPACE;
    self.currentPosView.frame = r;

    [self.xAxisLabel sizeToFit];
    r = self.xAxisLabel.frame;
    r.origin.y = self.frame.size.height - X_AXIS_SPACE - PADDING + 2;
    self.xAxisLabel.frame = r;
//
//    [self bringSubviewToFront:self.legendView];
}

- (void)setData:(NSArray *)data {
    if(data != _data) {
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:[data count]];
        NSMutableDictionary *colors = [NSMutableDictionary dictionaryWithCapacity:[data count]];
        for(LineChartData *dat in data) {
            [titles addObject:dat.title];
            [colors setObject:dat.color forKey:dat.title];
        }
        
        _data = data;
        [self layoutSubviews];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = _COLOR(0xb5, 0xb5, 0xb5);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat availableHeight = self.bounds.size.height - 2 * PADDING - X_AXIS_SPACE;
    
    CGFloat stepWidth = 40;
    CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    if(self.data != nil && [self.data count] > 0){
        LineChartData *data = [self.data objectAtIndex:0];
        CGFloat width = data.itemCount * stepWidth;
        if(width > availableWidth)
            availableWidth = width;
    }
//    CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    CGFloat xStart = PADDING + self.yAxisLabelsWidth;
    CGFloat yStart = PADDING;
    
//    static CGFloat dashedPattern[] = {3,1};
    
    // draw scale and horizontal lines
    CGFloat heightPerStep = self.ySteps == nil || [self.ySteps count] == 0 ? availableHeight : (availableHeight / ([self.ySteps count] - 1));
    
    NSUInteger i = 0;
    CGContextSaveGState(c);
    CGContextSetLineWidth(c, 0.5);
    NSUInteger yCnt = [self.ySteps count];
    for(NSString *step in self.ySteps) {
        [color set];
        CGFloat h = [self.scaleFont lineHeight];
        CGFloat y = yStart + heightPerStep * (yCnt - 1 - i);
        CGRect rect = CGRectMake(yStart, y - h / 2, self.yAxisLabelsWidth - 6, h);
        [step drawInRect:CGRectMake(yStart, y - h / 2, self.yAxisLabelsWidth - 6, h) withFont:self.scaleFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentRight];

        CGContextSetLineWidth(c, 0.5);
        CGContextMoveToPoint(c, xStart, round(y) + 0.5);
        CGContextAddLineToPoint(c, self.bounds.size.width - PADDING, round(y) + 0.5);
        CGContextStrokePath(c);
        
        i++;
    }
    CGContextRestoreGState(c);
    
    //不支持滑动，屏蔽了
//    xStart += self.xDisplacement;
    
    CGRect availableRect = CGRectMake( PADDING + self.yAxisLabelsWidth - 4, 0, self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth + 8, availableHeight + PADDING *2 + X_AXIS_SPACE);
    CGContextAddRect(c, availableRect);
    CGContextClip(c);
    
//    CGContextSaveGState(c);
//    CGContextSetLineWidth(c, 1.0);
//    NSUInteger xCnt = self.xStepsCount;
//    if(xCnt > 1) {
//        CGFloat widthPerStep = availableWidth / (xCnt - 1);
//        
//        [[UIColor grayColor] set];
//        for(NSUInteger i = 0; i < xCnt; ++i) {
//            CGFloat x = xStart + widthPerStep * (xCnt - 1 - i);
//            
//            [[UIColor colorWithWhite:0.9 alpha:1.0] set];
//            CGContextMoveToPoint(c, round(x) + 0.5, PADDING);
//            CGContextAddLineToPoint(c, round(x) + 0.5, yStart + availableHeight);
//            CGContextStrokePath(c);
//        }
//    }
//    
//    CGContextRestoreGState(c);


    if (!self.drawsAnyData) {
        NSLog(@"You configured LineChartView to draw neither lines nor data points. No data will be visible. This is most likely not what you wanted. (But we aren't judging you, so here's your chart background.)");
    } // warn if no data will be drawn
    
    CGFloat yRangeLen = self.yMax - self.yMin;
    int j = 0;
    for(LineChartData *data in self.data) {
        if (self.drawsDataLines) {
            float xRangeLen = data.xMax - data.xMin;
            if(data.itemCount >= 2) {
                LineChartDataItem *datItem = data.getData(0);
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL,
                                  xStart + round(((datItem.x - data.xMin) / xRangeLen) * availableWidth),
                                  yStart + round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight));
                for(NSUInteger i = 1; i < data.itemCount; ++i) {
                    LineChartDataItem *datItem = data.getData(i);
                    CGPathAddLineToPoint(path, NULL,
                                         xStart + round(((datItem.x - data.xMin) / xRangeLen) * availableWidth),
                                         yStart + round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight));
                }
                
                CGContextAddPath(c, path);
                CGContextSetStrokeColorWithColor(c, [data.color CGColor]);
                CGContextSetLineWidth(c, 1.2);
                CGContextStrokePath(c);
                
                CGPathRelease(path);
            }
        } // draw actual chart data
        if (self.drawsDataPoints) {
            float xRangeLen = data.xMax - data.xMin;
//            for(NSUInteger i = 0; i < data.itemCount; ++i) {
//                LineChartDataItem *datItem = data.getData(i);
//                CGFloat xVal = xStart + round((xRangeLen == 0 ? 0.5 : ((datItem.x - data.xMin) / xRangeLen)) * availableWidth);
//                CGFloat yVal = yStart + round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight);
//                [self.backgroundColor setFill];
//                CGContextFillEllipseInRect(c, CGRectMake(xVal - 5.5, yVal - 5.5, 11, 11));
//                [[UIColor whiteColor] setFill];
//                CGContextFillEllipseInRect(c, CGRectMake(xVal - 3, yVal - 3, 6, 6));
//                
//                [data.color setFill];
//                CGContextFillEllipseInRect(c, CGRectMake(xVal - 2, yVal - 2, 4, 4));
//            } // for
        } // draw data points
        
        if (self.drawsDataPoints && j == 0) {
            float xRangeLen = data.xMax - data.xMin;
            for(NSUInteger i = 0; i < data.itemCount; ++i) {
                LineChartDataItem *datItem = data.getData(i);
                CGFloat xVal = xStart + round((xRangeLen == 0 ? 0.5 : ((datItem.x - data.xMin) / xRangeLen)) * availableWidth);
                CGFloat yVal = yStart + round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight);
                [self.backgroundColor setFill];
                [color set];
                CGRect rect = CGRectMake(xVal - 15, self.frame.size.height - 15 , 30, 12);
                [datItem.xLabel drawInRect:rect withFont:self.scaleFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
            } // for
        } // draw data points
        
        j ++;
    }
}

- (void)showIndicatorForTouch:(UITouch *)touch {
    return;
    if(! self.infoView) {
        self.infoView = [[InfoView alloc] init];
        [self addSubview:self.infoView];
    }
    
    CGPoint pos = [touch locationInView:self];
    CGFloat xStart = PADDING + self.yAxisLabelsWidth;
    
    xStart += self.xDisplacement;
    
    CGFloat yStart = PADDING;
    CGFloat yRangeLen = self.yMax - self.yMin;
    CGFloat xPos = pos.x - xStart;
    CGFloat yPos = pos.y - yStart;
    CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    CGFloat stepWidth = 40;
    if(self.data != nil && [self.data count] > 0){
        LineChartData *data = [self.data objectAtIndex:0];
        CGFloat width = data.itemCount * stepWidth;
        if(width > availableWidth)
            availableWidth = width;
    }
    
    CGFloat availableHeight = self.bounds.size.height - 2 * PADDING - X_AXIS_SPACE;
    
    LineChartDataItem *closest = nil;
    float minDist = FLT_MAX;
    float minDistY = FLT_MAX;
    CGPoint closestPos = CGPointZero;
    
    for(LineChartData *data in self.data) {
        float xRangeLen = data.xMax - data.xMin;
        for(NSUInteger i = 0; i < data.itemCount; ++i) {
            LineChartDataItem *datItem = data.getData(i);
            CGFloat xVal = round((xRangeLen == 0 ? 0.5 : ((datItem.x - data.xMin) / xRangeLen)) * availableWidth);
            CGFloat yVal = round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight);
            
            float dist = fabsf(xVal - xPos);
            float distY = fabsf(yVal - yPos);
            if(dist < minDist || (dist == minDist && distY < minDistY)) {
                minDist = dist;
                minDistY = distY;
                closest = datItem;
                closestPos = CGPointMake(xStart + xVal - 3, yStart + yVal - 7);
            }
        }
    }
    
    self.infoView.infoLabel.attributedText = closest.dataLabel;
    self.infoView.detailinfoLabel.text = closest.detail;
    self.infoView.tapPoint = closestPos;
    [self.infoView sizeToFit];
    [self.infoView setNeedsLayout];
    [self.infoView setNeedsDisplay];
    
    self.xAxisLabel.backgroundColor = [UIColor yellowColor];
    self.currentPosView.backgroundColor = [UIColor whiteColor];
    
    
    if(self.currentPosView.alpha == 0.0) {
        CGRect r = self.currentPosView.frame;
        r.origin.x = closestPos.x + 3 - 1;
        self.currentPosView.frame = r;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.infoView.alpha = 1.0;
        self.currentPosView.alpha = 1.0;
        self.xAxisLabel.alpha = 0.0;
        
        CGRect r = self.currentPosView.frame;
        r.origin.x = closestPos.x + 3 - 1;
        self.currentPosView.frame = r;
        
        self.xAxisLabel.text = closest.xLabel;
        if(self.xAxisLabel.text != nil) {
            [self.xAxisLabel sizeToFit];
            r = self.xAxisLabel.frame;
            r.origin.x = round(closestPos.x - r.size.width / 2);
            self.xAxisLabel.frame = r;
        }
    }];
}

- (void)hideIndicator {
    [UIView animateWithDuration:0.1 animations:^{
        self.infoView.alpha = 0.0;
        self.currentPosView.alpha = 0.0;
        self.xAxisLabel.alpha = 0.0;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self showIndicatorForTouch:[touches anyObject]];
    [super touchesBegan:touches withEvent:event];
    storeTouches = [touches copy];
    prevPoint = [[storeTouches anyObject] locationInView:self];
    self.isMove = NO;
    
    CGFloat availableHeight = self.bounds.size.height - 2 * PADDING - X_AXIS_SPACE;
    

    CGRect availableRect = CGRectMake( PADDING + self.yAxisLabelsWidth - 4, 0, self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth + 8, availableHeight + PADDING *2 + X_AXIS_SPACE);
    if(prevPoint.x < availableRect.origin.x || prevPoint.x > availableRect.origin.x + availableRect.size.width)
        return;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    self.isMove = YES;
//    [self showIndicatorForTouch:[touches anyObject]];
    
    CGFloat stepWidth = 60;
    CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    if(self.data != nil && [self.data count] > 0){
        LineChartData *data = [self.data objectAtIndex:0];
        CGFloat width = data.itemCount * stepWidth;
        if(width > availableWidth)
            availableWidth = width;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - prevPoint.x;
    
    if(self.xDisplacement + dx <= 0 && self.xDisplacement + dx >= (self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth - 10) - availableWidth){
    
        self.xDisplacement = self.xDisplacement + dx;
        prevPoint = point;
        
        [self setNeedsDisplay];
    }
    [self hideIndicator];
    [timer invalidate];
    timer = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [timer invalidate];
    timer = nil;
    storeTouches = nil;
    [self hideIndicator];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self hideIndicator];
    [super touchesCancelled:touches withEvent:event];
}


#pragma mark Helper methods

- (void)changeTimeAtTimedisplay{
    if(!self.isMove){
        [self showIndicatorForTouch:[storeTouches anyObject]];
    }
}

- (BOOL)drawsAnyData {
    return self.drawsDataPoints || self.drawsDataLines;
}

// TODO: This should really be a cached value. Invalidated iff ySteps changes.
- (CGFloat)yAxisLabelsWidth {
    NSNumber *requiredWidth = [[self.ySteps mapWithBlock:^id(id obj) {
        NSString *label = (NSString*)obj;
        CGSize labelSize = [label sizeWithFont:self.scaleFont];
        return @(labelSize.width); // Literal NSNumber Conversion
    }] valueForKeyPath:@"@max.self"]; // gets biggest object. Yeah, NSKeyValueCoding. Deal with it.
    return [requiredWidth floatValue] + PADDING;
}

@end
