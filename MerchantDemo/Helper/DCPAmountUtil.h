//
//  DCPAmountUtil.h
//  DCPay
//
//  Created by zhanbin on 2018/4/29.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPAmountUtil : NSObject

/**
 返回界面上显示的数量
 
 @param amount 服务端返回的数量
 @param decimals 精度
 @return 界面上显示的数量
 */
+ (NSString *)getShowAmountValue:(NSString *)amount decimals:(int)decimals;

/**
 获取换算了精度的值
 
 @param amount 数量
 @param decimals 精度
 @return 换算了精度的值
 */
+ (double)getDecimalsAmount:(double)amount decimals:(int)decimals;

@end
