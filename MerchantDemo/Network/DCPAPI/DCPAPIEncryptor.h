//
//  DCPAPIEncryptor.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 加密结果
 */
@class DCPAPIEncryptedResponse;

@interface DCPAPIEncryptResult : NSObject

/**
 签名结果，BASE64
 **/
@property (nonatomic,copy)  NSString*   signature;

/**
 加密结果,BASE64
 **/
@property (nonatomic,copy)  NSString*   cipher;

/**
 加密向量,BASE64
 **/
@property (nonatomic,copy)  NSString* iv;

/**
 密钥密文数据,BASE64
 **/
@property(nonatomic,copy)   NSString*   key;

@end

@protocol DCPAPIEncryptor

-(DCPAPIEncryptResult*)encrypt:(NSData*)plainData;
-(NSData*)decrypt:(DCPAPIEncryptedResponse*)encryptedResponse;

@end

@interface DCPAPIDefaultEncryptor : NSObject<DCPAPIEncryptor>

-(id)initWithPrivateKey:(NSString*)privateKeyPemForSign andServerPublicKey:(NSString*)publicKeyPemForEncrypt;

@end
