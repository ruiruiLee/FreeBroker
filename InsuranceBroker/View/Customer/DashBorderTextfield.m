//
//  DashBorderTextfield.m
//  
//
//  Created by LiuZach on 15/12/24.
//
//

#import "DashBorderTextfield.h"
#import "define.h"

@implementation DashBorderTextfield
@synthesize delegate;
@synthesize textfield;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _maxTagLength = 18;
        self.backgroundColor = [UIColor clearColor];
        
        textfield = [[UITextField alloc] initWithFrame:CGRectMake(frame.size.height/2, 0, frame.size.width - frame.size.height, frame.size.height)];
        [self addSubview:textfield];
        textfield.font = _FONT(15);
        textfield.textColor = _COLOR(0x75, 0x75, 0x75);
        textfield.placeholder = @"添加标签";
        textfield.delegate = self;
        textfield.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    return self;
}

- (void) setFrame:(CGRect)_frame
{
    [super setFrame:_frame];
    
    textfield.frame = CGRectMake(_frame.size.height/2, 0, _frame.size.width - _frame.size.height, _frame.size.height);
}

- (void)drawRect:(CGRect)rect
{
    CGRect frame = self.frame;
    [line removeFromSuperlayer];
    line =  [CAShapeLayer layer];
    
    line.lineDashPhase = 2;
    line.lineDashPattern = @[[NSNumber numberWithInt:4], [NSNumber numberWithInt:2]];
    
    CGMutablePathRef  path =  CGPathCreateMutable();
    line.lineWidth = 1.0f ;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = [UIColor clearColor].CGColor;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    
    CGPathMoveToPoint(path, &transform, frame.size.height/2, 0);
    
    CGFloat radius = frame.size.height/2;
    //右上角和右下角两个点，画出半个圆角
    CGPathAddArcToPoint(path, &transform, frame.size.width, 0, frame.size.width, frame.size.height, radius);
    //右下角和左下角两个点，画出另外半个圆角
    CGPathAddArcToPoint(path, &transform, frame.size.width, frame.size.height, 0, frame.size.height, radius);
    
    CGPathAddArcToPoint(path, &transform, 0, frame.size.height, 0, 0, radius);
    CGPathAddArcToPoint(path, &transform, 0, 0, frame.size.height/2, 0, radius);
    
    line.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:line];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
//    if ([text isEqualToString:@" "] || [text isEqualToString:@"\n"])
//    {
//        if (textView.text.length > 0)
//        {
//            [self addTagToLast:textView.text animated:YES];
//            textView.text = @"";
//        }
//        
//        if ([text isEqualToString:@"\n"])
//        {
//            [textView resignFirstResponder];
//        }
//        
//        return NO;
//    }
    
    CGFloat currentWidth = [self widthForInputViewWithText:textField.text];
    CGFloat newWidth = 0;
    NSString *newText = nil;
    
    if (text.length == 0)
    {
        // delete
        if (textField.text.length)
        {
            newText = [textField.text substringWithRange:NSMakeRange(0, textField.text.length - range.length)];
        }
        else
        {
            [self detectBackspace];
            return NO;
        }
    }
    else
    {
        if (textField.text.length + text.length > _maxTagLength)
        {
            return NO;
        }
        newText = [NSString stringWithFormat:@"%@%@", textField.text, text];
    }
    newWidth = [self widthForInputViewWithText:newText];
    
    CGRect inputRect = self.frame;
    inputRect.size.width = newWidth;
    self.frame = inputRect;
    [self setNeedsDisplay];
    
    return YES;
}

- (CGFloat)widthForInputViewWithText:(NSString *)text
{
    return MAX(86.0, [text sizeWithAttributes:@{NSFontAttributeName:textfield.font}].width + self.frame.size.height);
}

- (void)detectBackspace
{
    if (textfield.text.length == 0)
    {
        if (_readyToDelete)
        {
            // remove lastest tag
//            if (_tagsMade.count > 0)
//            {
//                NSString *deletedTag = _tagsMade.lastObject;
//                [self removeTag:deletedTag animated:YES];
            if(delegate && [delegate respondsToSelector:@selector(DelPrevTag:)]){
                BOOL flag = [delegate DelPrevTag:self];
            }
                _readyToDelete = NO;
//            }
        }
        else
        {
            _readyToDelete = YES;
        }
    }
}

@end
