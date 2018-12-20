//
//  DCPTransactionResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPTransactionResponse : DCPBaseModel

@property (nonatomic, copy) NSString* txDbId;

@property (nonatomic, copy) NSString* txParams;

@end
