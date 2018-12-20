//
//  DCPQueryTransactionRequest.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPQueryTransactionRequest : DCPBaseModel

/**
 账号地址列表
 */
@property (nonatomic, strong) NSArray<NSString *>* address;

/**
 币ID
 */
@property (nonatomic, copy) NSString* coinId;
//@property (nonatomic, copy) NSString* goodsTag;
//@property (nonatomic, copy) NSString* goodsType;

/**
 页数（第0页开始）
 */
@property (nonatomic, assign) NSInteger pageNo;

/**
 每页数量
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 搜索key
 */
@property (nonatomic, copy) NSString* searchKey;

/**
 1 处理中 2 支付成功
 */
@property (nonatomic, copy) NSString* status;

/**
 时间 格式：yyyy-MM
 */
@property (nonatomic, copy) NSString* time;
//@property (nonatomic, copy) NSString* tokenAddress;

/**
 类型：0-支付payment 1-转账transfer 3-Recived 4-send 5-all
 */
@property (nonatomic, copy) NSString* type;

/**
 下拉刷新不传，上拉加载更多需要传服务端返回的uuid（有uuid的情况服务端使用缓存数据）
 */
@property (nonatomic, copy) NSString* uuid;

/**
 商家名称
 */
@property (nonatomic, copy) NSString* merchantName;

/**
 所属行业 ","分隔
 */
@property (nonatomic, copy) NSString* industry;

@end
