//
//  DCPMerchantDetail.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

@interface DCPMerchantDetail : DCPBaseModel

@property (nonatomic, copy) NSString* name;// 商家名称
@property (nonatomic, copy) NSString* logoBill;// 商家支付logo
@property (nonatomic, copy) NSString* desc;//商家介绍
@property (nonatomic, copy) NSString* website;//商家官方网站
@property (nonatomic, copy) NSString* logoIntro;//商家介绍logo
@property (nonatomic, copy) NSString* rsaPublic;

@end
