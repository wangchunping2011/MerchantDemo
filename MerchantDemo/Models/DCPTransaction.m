//
//  DCPTransaction.m
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPTransaction.h"
#import "DCPResource.h"

@implementation DCPTransaction

- (NSString *)getStatusDescription {
    NSInteger statusInteger = [_status integerValue];
    NSString *statusDescription = @"";
    switch (statusInteger) {
        case -1:
            statusDescription = DCPString(@"paymentStatusSended");//@"sended";
            break;
        case 0:
            statusDescription = DCPString(@"paymentStatusPending");//@"pending";
            break;
        case 1:
            statusDescription = DCPString(@"paymentStatusFailed");//@"fail";
            break;
        case 2:
            statusDescription = DCPString(@"paymentStatusPending");//@"pending";
            break;
        case 3:
            statusDescription = DCPString(@"paymentStatusSuccess");//@"success";
            break;
        case 4:
            statusDescription = DCPString(@"paymentStatusUnpaid");//@"unpaid";
            break;
        case 5:
            statusDescription = DCPString(@"paymentStatusPending");//@"pending";
            break;
        case 6:
            statusDescription = DCPString(@"paymentStatusSuccess");//@"success";
            break;
        case 7:
            statusDescription = DCPString(@"paymentStatusFailed");//@"fail";
            break;
        default:
            break;
    }
    return statusDescription;
}

@end
