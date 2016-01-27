//
//  DashBorderTextfield.h
//  
//
//  Created by LiuZach on 15/12/24.
//
//

#import <UIKit/UIKit.h>

@class DashBorderTextfield;

@protocol DashBorderTextfieldDelegate <NSObject>

- (BOOL) DelPrevTag:(DashBorderTextfield *) sender;

@end

@interface DashBorderTextfield : UIView <UITextFieldDelegate>
{
    BOOL _readyToDelete;
    
    NSInteger _maxTagLength;
    
    CAShapeLayer *line;
}

@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, weak) id<DashBorderTextfieldDelegate> delegate;

@end
