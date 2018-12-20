//
//  DCPAPIRequestBuilder.h
//  DCPay
//
//  Created by vken on 2018/4/5.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPAPIRequest.h"
#import "DCPAPIRequestExcutor.h"
#import "DCPAPIEncryptor.h"


@interface DCPAPIRequestBuilder : NSObject

+(instancetype _Nonnull)appBuilder;

-(instancetype _Nonnull)initWithMerchantId:(NSString* _Nonnull)merchantId WithApiVerison:(NSString* _Nonnull)apiVersion withEncryptor:(id<DCPAPIEncryptor> _Nonnull)encryptor;

-(DCPAPIRequest*)requestWithUrl:(NSString* _Nonnull)url withMethod:(NSString* _Nonnull)method withParameters:(NSDictionary* _Nonnull)parameters;


@end
