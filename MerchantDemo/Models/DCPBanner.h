//
//  DCPBanner.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPBanner : DCPBaseModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *imageUrl;

@end
