//
//  NSDate+Extension.h
//
//  Created by ZJL on 15/12/17.
//  Copyright © 2015年 ZJL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

- (NSString *)dateDescription;
+ (NSDate *)dateFromLongLong:(long long)msSince1970;
@end
