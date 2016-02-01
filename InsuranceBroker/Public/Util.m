//
//  Util.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "Util.h"
#import "define.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Util


+ (NSString *)md5Hash:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result);
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}

+ (BOOL) isNilOrNull:(id) obj
{
    BOOL flag = NO;
    
    if(obj == nil)
        flag = YES;
    else if([obj isKindOfClass:[NSNull class]])
        flag = YES;
    
    return flag;
}

+ (CGFloat) getHeightByWidth:(CGFloat) owidth height:(CGFloat) oheight nwidth:(CGFloat)nwidth
{
    CGFloat result = 0;
    
    result = (oheight * nwidth) / owidth;
    
    return result;
}

+ (NSMutableAttributedString*) SetLabelLineSpace:(CGFloat) spacing Text:(NSString*) string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.lineSpacing = 10;//增加行高
//    style.headIndent = 10;//头部缩进，相当于左padding
//    style.tailIndent = -10;//相当于右padding
    style.lineHeightMultiple = spacing;//行间距是多少倍
    style.alignment = NSTextAlignmentCenter;//对齐方式
//    style.firstLineHeadIndent = 20;//首行头缩进
//    style.paragraphSpacing = 10;//段落后面的间距
//    style.paragraphSpacingBefore = 20;//段落之前的间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    
    return attributedString;
}

//绘图
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (NSString *)getCurrentVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

+ (void) setValueForKeyWithDic:(NSMutableDictionary *) mDic value:(id) value key:(NSString *) key
{
    if(value != nil && ![value isKindOfClass:[NSNull class]])
        [mDic setObject:value forKey:key];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    //手机号以13， 15，18开头，八个 \d 数字字符  14,17
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9])|(14[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
//    return [phoneTest evaluateWithObject:mobileNum];
    if([mobileNum length] > 0)
        return YES;
    else
        return NO;
}

+ (void)showAlertMessage:(NSString*)msg
{
    UIAlertView * mAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
    [mAlert show];
}

+ (NSString *) getShowingTime:(NSDate *)date
{
//    NSDateFormatter *dateFormatter = [Util dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *result = [dateFormatter stringFromDate:date];
    return [self compareDate:date];//result;
}

/**
 *  仿QQ空间时间显示
 *  @param string eg:2015年5月24日 02时21分30秒
 */
+ (NSString *)format:(NSString *)string{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    //NSLog(@"startDate= %@", inputDate);
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    //NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [self compareDate:endDate];
    NSLog(@"lastTime = %@",lastTime);
    return str;
}

+ (NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    
    toYears = [[today description] substringToIndex:4];
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [Util getDayString:date];//[[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [Util getTimeSecString:date];
        //其他时间
        NSString *time2 = [Util getDayAndTimeString:date];//[[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"今天 %@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}


+ (NSString *) getTimeString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [Util dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString *) getDayString:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [Util dateFormatterWithFormat:@"yyyy-MM-dd"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString *) getTimeSecString:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [Util dateFormatterWithFormat:@"HH:mm"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString *) getDayAndTimeString:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [Util dateFormatterWithFormat:@"MM-dd HH:mm"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *) format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return dateFormatter;
}

// 打开照相机
+ (void)openCamera:(UIViewController*)currentViewController allowEdit:(BOOL)allowEdit completion:(void (^)(void))completion
{
    UIImagePickerController  *picker = [[UIImagePickerController alloc] init];
    //
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.delegate      = (id)currentViewController;
        picker.allowsEditing = allowEdit;
        picker.sourceType    = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        //
        [currentViewController presentViewController:picker animated:YES completion:completion];
    }
}

//打开相册
+ (void)openPhotoLibrary:(UIViewController*)currentViewController allowEdit:(BOOL)allowEdit completion:(void (^)(void))completion
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    //
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        pickerImage.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        pickerImage.delegate      = (id)currentViewController;
        pickerImage.allowsEditing = allowEdit;
        //
        [currentViewController presentViewController:pickerImage animated:YES completion:completion];
    }
}

//图像等比例压缩 .充满空隙

+(UIImage *)fitSmallImage:(UIImage *)image scaledToSize:(CGSize)tosize
{
    if (!image)
    {
        return nil;
    }
    if (image.size.width<tosize.width && image.size.height<tosize.height)
    {
        return image;
    }
    CGFloat wscale = image.size.width/tosize.width;
    CGFloat hscale = image.size.height/tosize.height;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(image.size.width/scale, image.size.height/scale);
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 2.0);
    }else{
        UIGraphicsBeginImageContext(newSize);
    }
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    [image drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


+ (NSDate*) convertDateFromString:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH"];
    NSDate *date=[formatter dateFromString:string];
    return date;
}


//获取性别
+ (NSString *) getSexStringWithSex:(NSInteger) sex
{
    NSString *sexString = @"男";
    if (sex == 2) {
        sexString = @"女";
    }
    
    return sexString;
}

+ (NSString *) getAddrWithProvience:(NSString *)province city:(NSString *)city
{
    if(province == nil && city == nil){
        return @"请选择用户所在地区";
    }
    
    if(province == nil)
        province = @"";
    if(city == nil)
        city = @"";
    
    return [NSString stringWithFormat:@"%@  %@", province, city];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

+ (NSString *) getStringByPlanType:(NSInteger) planType
{//0未选择(默认），1强制型，2大众型，3加强型，4自定义
    switch (planType) {
        case 0:
        {
            return @"未选择";
        }
            break;
        case 1:
        {
            return @"强制型";
        }
            break;
        case 2:
        {
            return @"大众型";
        }
            break;
        case 3:
        {
            return @"加强型";
        }
            break;
        case 4:
        {
            return @"自定义";
        }
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *) getDecimalStyle:(CGFloat) num
{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:kCFNumberFormatterDecimalStyle];
    return [numFormatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

+ (NSMutableAttributedString *)getWarningString:(NSString*) string
{
    NSString *UnitPrice = string;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [UnitPrice rangeOfString:@"*"];
    [attString addAttribute:NSForegroundColorAttributeName value:_COLOR(0xf4, 0x43, 0x36) range:range];
    return attString;
}

+ (NSMutableAttributedString *)getAttributeString:(NSString*) string substr:(NSString *)substr
{
    NSString *UnitPrice = string;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [UnitPrice rangeOfString:substr];
    [attString addAttribute:NSForegroundColorAttributeName value:_COLOR(0xff, 0x66, 0x19) range:range];
    return attString;
}

//图像等比例压缩 .充满空隙

@end
