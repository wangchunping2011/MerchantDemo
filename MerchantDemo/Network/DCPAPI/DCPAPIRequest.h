//
//  DCPAPIRequest.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPIRequestExcutor.h"
#import "DCPAPIEncryptor.h"

extern NSString* _Nonnull const DCPAPIRequestHeaderFiledName;

@interface DCPAPIRequestHeader : NSObject

@property (nonatomic,copy)  NSString* _Nonnull  merchantId;
//默认RSA
@property (nonatomic,copy)  NSString* _Nonnull  signType;
//默认UTF-8
@property (nonatomic,copy)  NSString* _Nonnull  charset;

@property (nonatomic,copy)  NSString* _Nonnull  timestamp;
@property (nonatomic,copy)  NSString* _Nonnull  signature;

@property(nonatomic,copy,readonly)   NSString* _Nonnull  serializition;

@property(nonatomic,copy)   NSString* _Nonnull  apiVersion;
@property(nonatomic,copy)   NSString* _Nonnull  method;
@property(nonatomic,copy)   NSDictionary* _Nonnull  device;

-(void)serialize;

-(void)updateTimestamp;

@end


@interface DCPAPIRequestBody : NSObject

@property(nonatomic,copy)   NSDictionary* _Nonnull  parameters;

@property(nonatomic,copy,readonly)   NSString* _Nonnull  serializition;

-(void)serialize;

@end

@interface DCPAPIRequest : NSObject

-(instancetype _Nonnull)initWithUrl:(NSString* _Nonnull)url withHeader:(DCPAPIRequestHeader * _Nonnull)header withBody:(DCPAPIRequestBody * _Nonnull)body withExecutor:(id<DCPAPIRequestExecutor> _Nonnull) executor withEncryptor:(id<DCPAPIEncryptor> _Nonnull) encryptor;

@property(nonatomic,strong,readonly) DCPAPIRequestHeader* _Nonnull   header;
@property(nonatomic,strong,readonly) DCPAPIRequestBody* _Nonnull     body;

@property(nonatomic,strong,readonly) DCPAPIEncryptResult * _Nonnull encryptedResult;
@property(nonatomic,strong,readonly) NSMutableDictionary* _Nonnull postBody;

@property(nonatomic,assign,readonly) id<DCPAPIRequestExecutor> _Nonnull   executor;
@property(nonatomic,assign,readonly) id<DCPAPIEncryptor> _Nonnull encryptor;

@property(nonatomic,copy)   NSString* _Nonnull  url;

-(void)serialize;

-(void)post:(void (^_Nonnull)(NSString* _Nullable message,id _Nonnull data))success
    failure:(void (^_Nonnull)(NSString* _Nullable message,NSInteger code))failure;

@end

