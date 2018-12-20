//
//  DCPNotification.m
//  DCPay
//
//  Created by zhanbin on 2018/4/8.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPNotification.h"

@implementation DCPNotification

+(void)initialize
{
    //模型中的属性名和字典中的key不相同(或者需要多级映射)
    [DCPNotification mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"notificationId":@"id"
                 };
    }];
    
}

-(void)setType:(NSString *)type{
    _type = type;
    if ([type isEqualToString:@"TRANSFER"]) {
        
        _typeEnum = DCPNotificationTypeTRANSFER;
    } else if ([type isEqualToString:@"PAYMENT"]) {
        
        _typeEnum = DCPNotificationTypePAYMENT;
    } else if ([type isEqualToString:@"NOTIFY"]) {
        
        _typeEnum = DCPNotificationTypeNOTIFY;
    }
}

@end
