//
//  DCPAPIResponse.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPAPIEncryptor.h"
@interface DCPAPIResponse : NSObject

@property(nonatomic,copy)      NSString* _Nonnull method;
@property(nonatomic,copy)      NSString* _Nonnull message;
@property(nonatomic,assign)    NSInteger  code;
@property(nonatomic,strong)    id _Nonnull data;

@end

@interface DCPAPIEncryptedResponse : NSObject

@property(nonatomic,copy)   NSString* _Nonnull iv;
@property(nonatomic,copy)   NSString* _Nonnull key;
@property(nonatomic,copy)   NSString* _Nonnull cipher;
@property(nonatomic,copy)   NSString* _Nonnull signature;

-(id _Nonnull )initWithJSON:(NSDictionary *_Nonnull)json;

-(DCPAPIResponse*_Nullable)decrypt:(id<DCPAPIEncryptor>)encryptor;

@end


