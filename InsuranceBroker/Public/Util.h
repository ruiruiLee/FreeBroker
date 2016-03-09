//
//  Util.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Util : NSObject

+ (NSString *)md5Hash:(NSString *)str;
+ (BOOL) isNilOrNull:(id) obj;

//计算实际高度
+ (CGFloat) getHeightByWidth:(CGFloat) owidth height:(CGFloat) oheight nwidth:(CGFloat)nwidth;

+ (NSMutableAttributedString*) SetLabelLineSpace:(CGFloat) spacing Text:(NSString*) string;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//获取版本号
+ (NSString *)getCurrentVersion;//

//字典添加值
+ (void) setValueForKeyWithDic:(NSMutableDictionary *) mDic value:(id) value key:(NSString *) key;

//判断一字符串是否电话
+ (BOOL)isMobileNumber:(NSString *)mobileNum;//判断固定电话
+ (BOOL)isMobilePhoeNumber:(NSString *)mobileNum;
+ (NSString *)formatPhoneNum:(NSString *)phone;
+(BOOL) checkPhoneNumInput:(NSString *)phone;//判断固定电话

+ (void)showAlertMessage:(NSString*)msg;

//获取客户主界面展示 like 今天 19:08
+ (NSString *) getShowingTime:(NSDate *)date;
+ (NSString *) getTimeString:(NSDate *)date;
+ (NSString *) getDayString:(NSDate *) date;
+ (NSDate*) convertDateFromString:(NSString*)string;

+ (void)openCamera:(UIViewController*)currentViewController allowEdit:(BOOL)allowEdit completion:(void (^)(void))completion;
+ (void)openPhotoLibrary:(UIViewController*)currentViewController allowEdit:(BOOL)allowEdit completion:(void (^)(void))completion;
+(UIImage *)fitSmallImage:(UIImage *)image scaledToSize:(CGSize)tosize;

//获取性别
+ (NSString *) getSexStringWithSex:(NSInteger) sex;

//获取住址，精确到市
+ (NSString *) getAddrWithProvience:(NSString *)province city:(NSString *)city;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)value;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//根据订单方案类型获取说明
+ (NSString *) getStringByPlanType:(NSInteger) planType;

+ (NSString *) getDecimalStyle:(CGFloat) num;

+ (NSMutableAttributedString *)getWarningString:(NSString*) string;
+ (NSMutableAttributedString *)getAttributeString:(NSString*) string substr:(NSString *)substr;


@end
