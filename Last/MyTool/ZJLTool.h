//
//  ZJLTool.h
//
//  Created by Mr郑 on 2017/6/17.
//  Copyright © 2017年 Mr郑 QQ:378944429. All rights reserved.
//


// 1.颜色
#define DEFAULTCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RandomColor RGBACOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1.0)

// 2.屏幕尺寸
#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height

// 3.自定义Log
#ifdef DEBUG
#define KLog(...) NSLog(__VA_ARGS__)
#else
#define KLog(...)
#endif

#define IOS_VERSION [[UIDevice currentDevice] systemVersion]>=9.0




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface ZJLTool : NSObject

/**
 *  返回一个单例数据库对象
 *
 *  @return 返回一个单例数据库对象
 */
//+(FMDatabase*)sharedDataBase;

/**
 弹出HUD提示框
 
 @param type 提示框种类
 @param text 提示信息
 */
+ (void)popMBProgressHUDNoticeWithHUDType:(NSInteger)type andNoticeStr:(NSString*)text andInView:(UIView*)view;

/**
 *  MD5加密，32位小写
 *
 *  @param str 需要加密的内容
 *
 *  @return 返回加密后的内容
 */
+ (NSString *)encryptUseMd5WithString:(NSString *)str;

/**
 *  DES加密
 *
 *  @param str 需要加密的内容
 *  @param key    加密的Key
 *
 *  @return 返回加密后的内容
 */
+ (NSString *)encryptUseDES:(NSString *)str key:(NSString *)key;

/**
 *  判断手机号格式
 *
 *  @param mobile 输入的手机号
 *
 *  @return 返回是否正确格式手机号(BOOL)
 */
+ (BOOL)valiMobile:(NSString *)mobile;

/**
 *  判断邮箱格式
 *
 *  @param email 参数
 *
 *  @return 返回值
 */
+ (BOOL)isValidateEmail:(NSString *)email;


/**
 设置导航栏返回按钮文字
 
 @param str 参数
 */
+ (void)setNaviBarGobackTitleWithStr:(NSString*)str inVC:(UIViewController*)vc;


/**
 时间转换
 
 @param time 时间
 @param format 日期格式
 @return 日期
 */
+ (NSString*)transformTimeToDateWithSeconds:(NSInteger)time andDateFormat:(NSString*)format;


/**
 设置文本格式
 
 @param str 文本
 @return 结果
 */
+ (NSDictionary*)setLabelTextAttributeWithStr:(NSString*)str;

/**
 设置字体大小颜色
 
 @param label 参数
 @param font 字体
 @param range 范围
 @param color 颜色
 */
+ (void)setLabel:(UILabel *)label AndFont:(UIFont*)font AndRange:(NSRange)range AndColor:(UIColor *)color;


@end
