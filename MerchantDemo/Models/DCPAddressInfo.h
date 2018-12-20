//
//  DCPAddress.h
//  DCPay
//
//  Created by 詹斌 on 2018/4/15.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPAddressInfo : NSObject

@property (nonatomic, assign) NSInteger addressId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, copy) NSString *address;

@end
