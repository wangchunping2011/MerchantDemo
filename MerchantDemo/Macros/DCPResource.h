//
//  DCPResource.h
//  DCPay
//
//  Created by liaofulin on 2018/3/25.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <YYCategories/UIColor+YYAdd.h>
#import "DCPI18nManager.h"

static NSString * const defaultValueApiVersion = @"1.0.0";
static NSString * const defaultValueAppMechantId = @"10000000000003";
//渠道
static NSString * const defaultChannel = @"73088886094001";

// 本地化字符串
//#define DCPString(key) NSLocalizedString(key, nil)
#define DCPString(key) [DCPI18nManager localizedStringWithKey:key]

// 颜色
#define DCPMainColor UIColorHex(#363A44)
#define DCPWhiteColor [UIColor whiteColor]
#define DCPBlackColor [UIColor blackColor]
#define DCPGrayColor [UIColor grayColor]
#define DCPColor_1 UIColorHex(#363A44)
#define DCPColor_2 UIColorHex(#1F2127)
#define DCPColor_3 UIColorHex(#34A9FF)
#define DCPColor_4 UIColorHex(#979797)
#define DCPColor_5 UIColorHex(#5D5C71)
#define DCPColor_6 UIColorHex(#F4F4F4)
#define DCPColor_7 UIColorHex(#F2F2F2)
#define DCPColor_8 UIColorHex(#FF6960)
#define DCPColor_9 UIColorHex(#1E1C2A)
#define DCPColor_10 UIColorHex(#00BD9A)
#define DCPColor_11 UIColorHex(#B3B3BA)
#define DCPColor_12 UIColorHex(#FEBE17)
#define DCP_TextBorderColor UIColorHex(#353944)
//按钮字体蓝色
#define DCPBtnBlueColor UIColorHex(#34A9FF)

//Payment
#define DCPColorPaymentWallet UIColorHex(#353342)
#define DCPColorPaymentStatus UIColorHex(#5D5C70)
#define DCPColorPaymentRecent UIColorHex(#6D6C7E)

//Balance
#define DCPColorBalanceWarning UIColorHex(#FEBE17)

// 分割线
#define DCPLineColor_3 UIColorHex(#353343)

// 字体
#define DCPFont_12 [UIFont systemFontOfSize:12]
#define DCPFont_13 [UIFont systemFontOfSize:13]
#define DCPFont_14 [UIFont systemFontOfSize:14]
#define DCPFont_15 [UIFont systemFontOfSize:15]
#define DCPFont_16 [UIFont systemFontOfSize:16]
#define DCPFont_17 [UIFont systemFontOfSize:17]
#define DCPFont_18 [UIFont systemFontOfSize:18]
#define DCPFont_19 [UIFont systemFontOfSize:19]
#define DCPFont_20 [UIFont systemFontOfSize:20]
#define DCPFont_24 [UIFont systemFontOfSize:24]
#define DCPFont_48 [UIFont systemFontOfSize:48]

#pragma mark - 判断空值
//判断空数组
#define ISNULLARRAY(arr) (arr == nil || (NSObject *)arr == [NSNull null] || arr.count == 0)
// 判断空值
#define ISNULL(obj)      (obj == nil || (NSObject *)obj == [NSNull null])
//判断空字符串
#define ISNULLSTR(str)   (str == nil || (NSObject *)str == [NSNull null] || str.length == 0 || [str isEqualToString:@"(null)"])


//数据太长无法在控制台完全输出，用DCPLog可解决
#ifdef DEBUG
#define DCPLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DCPLog(format, ...)

#endif

