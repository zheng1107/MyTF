//
//  ZJLTool.m
//
//  Created by Mr郑 on 2017/6/17.
//  Copyright © 2017年 Mr郑 QQ:378944429. All rights reserved.
//


//加密参数
#define CC_MD5_DIGEST_LENGTH 16

#import "ZJLTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation ZJLTool

//该方法返回单例数据库对象
/*
+(FMDatabase*)sharedDataBase{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"LoveHomeData" ofType:@"db"];
    
    static FMDatabase* db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [FMDatabase databaseWithPath:path];
    });
    
    [db open];
    return db;
}*/

//弹出HUD
+ (void)popMBProgressHUDNoticeWithHUDType:(NSInteger)type andNoticeStr:(NSString *)text andInView:(UIView *)view{

    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.animationType = MBProgressHUDAnimationZoom;

    if (1==type) {
        
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
        } completionBlock:^{
        [hud removeFromSuperview];
        }];
    }else{

        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zjl.bundle/check"]];
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [hud removeFromSuperview];
        }];
    }
}

//MD5加密，32位小写
+ (NSString *)encryptUseMd5WithString:(NSString *)str{
    
    const char *cStr = [str UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr,(CC_LONG) strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString string];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result lowercaseString];
}

//DES加密
+ (NSString *)encryptUseDES:(NSString *)str key:(NSString *)key{
    
    NSString *ciphertext = nil;
    NSData *textData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char buffer[1024];
    
    memset(buffer, 0, sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding|kCCOptionECBMode, [key UTF8String], kCCKeySizeDES, nil, textData.bytes, textData.length, buffer, 1024, &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *dataa = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [self parseByte2HexString:(Byte*)dataa.bytes andLength:dataa.length];
    }
    return ciphertext;
}

//二进制转十六进制，私有方法
+(NSString*)parseByte2HexString:(Byte*)bytes andLength:(NSInteger)num{
    
    NSMutableString *hexStr = [[NSMutableString alloc] init];
    
    if(bytes)
    {
        for (int i = 0; i < num; i++) {
            NSString *hexByte = [NSString stringWithFormat:@"%02X",bytes[i] & 0xff];
            [hexStr appendFormat:@"%@", hexByte];
        }
    }
    return hexStr;
}

//判断手机号格式
+ (BOOL)valiMobile:(NSString *)mobile{
    
    //移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    
    //联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    
    //电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        
        return YES;
    }else{
        
        return NO;
    }
}

//邮箱验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//设置导航栏返回按钮文字
+ (void)setNaviBarGobackTitleWithStr:(NSString *)str inVC:(UIViewController *)vc{
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] init];
    item.title = str;
    vc.navigationItem.backBarButtonItem = item;
}

//时间转换
+ (NSString *)transformTimeToDateWithSeconds:(NSInteger)time andDateFormat:(NSString *)format{
    
    NSDateFormatter* fom = [[NSDateFormatter alloc] init];
    fom.dateFormat = format;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString* dateStr = [fom stringFromDate:date];
    return dateStr;
}

//设置文本格式
+ (NSDictionary *)setLabelTextAttributeWithStr:(NSString *)str{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    NSDictionary* dic = @{@"str":attributedString,@"style":paragraphStyle};
    return dic;
}

//设置字体不同颜色
+ (void)setLabel:(UILabel *)label AndFont:(UIFont*)font AndRange:(NSRange)range AndColor:(UIColor *)color{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.attributedText = str;
}



@end
