//
//  DCPNotificationListResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPNotification.h"

@interface DCPNotificationListResponse : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<DCPNotification *>* list;

@end
