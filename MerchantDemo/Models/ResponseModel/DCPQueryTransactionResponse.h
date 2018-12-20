//
//  DCPQueryTransactionResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPTransaction.h"

@interface DCPQueryTransactionResponse : DCPBaseModel

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<DCPTransaction *>* list;

/**
 服务端记录缓存的id（客户端下拉刷新时记录该uuid，上拉加载更多时，传给服务端）
 */
@property (nonatomic, copy) NSString* uuid;

@end
