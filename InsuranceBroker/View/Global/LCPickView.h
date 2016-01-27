//
//  LCPickView.h
//  SpringCare
//
//  Created by LiuZach on 15/4/15.
//  Copyright (c) 2015年 cmkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCPickView;
@protocol LCPickViewDelegate <NSObject>

@optional
-(void)toobarDonBtnHaveClick:(LCPickView *)pickView resultString:(NSString *)resultString;
-(void)toobarDonBtnCancel:(LCPickView *)pickView;

@end

@interface LCPickView : UIView


@property(nonatomic,weak) id<LCPickViewDelegate> delegate;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic, strong) UILabel *lbTitle;

/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName          plist文件的名字
 
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler;
/**
 *  通过plistName添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color;
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color;

- (void) SetDatePickerMin:(NSDate *)date;

- (void) setCurrentSelectIdx:(NSInteger) idx;

@end
