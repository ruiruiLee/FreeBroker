//
//  LandscapeEventDetailView.m
//  Classes
//
//  Created by Marcel Ruegenberg on 19.11.09.
//  Copyright 2009 Dustlab. All rights reserved.
//

#import "InfoView.h"
#import "UIKit+DrawingHelpers.h"
#import "define.h"


@interface InfoView ()

- (void)recalculateFrame;

@end


@implementation InfoView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {		
        UIFont *fatFont = [UIFont systemFontOfSize:12];
        
        self.infoLabel = [[UILabel alloc] init]; self.infoLabel.font = fatFont;
        self.infoLabel.backgroundColor = [UIColor clearColor]; self.infoLabel.textColor = _COLOR(33, 158, 98);//[UIColor whiteColor];
        self.infoLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.numberOfLines = 0;
        [self addSubview:self.infoLabel];
        
        self.detailinfoLabel = [[UILabel alloc] init]; self.detailinfoLabel.font = fatFont;
        self.detailinfoLabel.backgroundColor = [UIColor clearColor]; self.detailinfoLabel.textColor = _COLOR(33, 158, 98);//[UIColor whiteColor];
        self.detailinfoLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        self.detailinfoLabel.textAlignment = NSTextAlignmentCenter;
        self.detailinfoLabel.numberOfLines = 0;
        [self addSubview:self.detailinfoLabel];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init {
	if((self = [self initWithFrame:CGRectZero])) {
		;
	}
	return self;
}

#define TOP_BOTTOM_MARGIN 3
#define LEFT_RIGHT_MARGIN 10
#define SHADOWSIZE 3
#define SHADOWBLUR 5
#define HOOK_SIZE 8

void CGContextAddRoundedRectWithHookSimple(CGContextRef c, CGRect rect, CGFloat radius) {
	//eventRect must be relative to rect.
	CGFloat hookSize = HOOK_SIZE;
	CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + radius, radius, M_PI, M_PI * 1.5, 0); //upper left corner
	CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, M_PI * 1.5, M_PI * 2, 0); //upper right corner
	CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 2, M_PI * 0.5, 0);
    {
		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2 + hookSize, rect.origin.y + rect.size.height);
		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height + hookSize);
		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2 - hookSize, rect.origin.y + rect.size.height);
	}
	CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 0.5, M_PI, 0);
	CGContextAddLineToPoint(c, rect.origin.x, rect.origin.y + radius);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self sizeToFit];
    
    [self recalculateFrame];
    
    [self.infoLabel sizeToFit];
    [self.detailinfoLabel sizeToFit];
    
    CGSize s = [self.infoLabel.text sizeWithFont:self.infoLabel.font];
    CGSize s1 = [self.detailinfoLabel.text sizeWithFont:self.infoLabel.font];
    self.infoLabel.frame = CGRectMake(self.bounds.origin.x + 7, self.bounds.origin.y + 8, self.frame.size.width - 14, s.height);
    self.detailinfoLabel.frame = CGRectMake(self.bounds.origin.x + 7, self.bounds.origin.y + 10 + s.height, s1.width, s1.height);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize s = [self.infoLabel.text sizeWithFont:self.infoLabel.font];
    CGSize s1 = [self.detailinfoLabel.text sizeWithFont:self.infoLabel.font];
    s.height += 15;
    
    if(s1.width > s.width)
        s.width = s1.width;
    
    s.height += SHADOWSIZE;
    s.height += s1.height + 10;
    
    s.width += 2 * SHADOWSIZE + 7;
    s.width = MAX(s.width, HOOK_SIZE * 2 + 2 * SHADOWSIZE + 10);
    
    return s;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();

	CGRect theRect = self.bounds;
//	//passe x oder y Position sowie Hoehe oder Breite an, je nachdem, wo der Hook sitzt.
	theRect.size.height -= SHADOWSIZE * 2;
	theRect.origin.x += SHADOWSIZE;
	theRect.size.width -= SHADOWSIZE * 2;
    theRect.size.height -= SHADOWSIZE * 2;
//
//    [[UIColor colorWithWhite:0.0 alpha:1.0] set];
    [[UIColor colorWithWhite:1.0 alpha:1.0] set];
	CGContextSetAlpha(c, 0.7);

	CGContextSaveGState(c);
	
//    CGContextSetShadow(c, CGSizeMake(0.0, SHADOWSIZE), SHADOWBLUR);
	
	CGContextBeginPath(c);
    CGContextAddRoundedRectWithHookSimple(c, theRect, 7);
	CGContextFillPath(c);
	
//    [[UIColor whiteColor] set];
//	theRect.origin.x += 1;
//	theRect.origin.y += 1;
//	theRect.size.width -= 2;
//	theRect.size.height = theRect.size.height / 2 + 1;
//	CGContextSetAlpha(c, 0.2);
//    CGContextFillRoundedRect(c, theRect, 6);
}



#define MAX_WIDTH 400
// calculate own frame to fit within parent frame and be large enough to hold the event.
- (void)recalculateFrame {
    CGRect theFrame = self.frame;
    theFrame.size.width = MIN(MAX_WIDTH, theFrame.size.width);
    
    CGRect theRect = self.frame; theRect.origin = CGPointZero;

    {
        theFrame.origin.y = self.tapPoint.y - theFrame.size.height + 2 * SHADOWSIZE + 1;
        theFrame.origin.x = round(self.tapPoint.x - ((theFrame.size.width - 2 * SHADOWSIZE)) / 2.0);
    }
    self.frame = theFrame;
}

@end
