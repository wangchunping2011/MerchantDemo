//
//  DCPNotificationListResponse.m
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPNotificationListResponse.h"

@implementation DCPNotificationListResponse

+(void)initialize
{
    
    //数组里面存的模型
    [DCPNotificationListResponse mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"DCPNotification"
                 };
    }];
    
}

@end
