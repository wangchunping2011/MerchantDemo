//
//  DCPAPIEncryptor.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPIEncryptor.h"
#import "DCPRSA.h"
#import "DCPAES.h"
#import "DCPRSAKey.h"
#import "NSError+DCPRSA.h"
#import "YYCategories.h"
#import "DCPAPIResponse.h"

@implementation DCPAPIEncryptResult

@end

@interface DCPAPIDefaultEncryptor()

@property(nonatomic,assign) SecKeyRef appPrivateKey;
@property(nonatomic,assign) SecKeyRef serverPublicKey;

@end

@implementation DCPAPIDefaultEncryptor

-(id)initWithPrivateKey:(NSString*)privateKeyPemForSign andServerPublicKey:(NSString*)publicKeyPemForEncrypt
{
    self = [super init];
    if(self)
    {
        NSError* error = nil;
        _appPrivateKey = [DCPRSAKey privateKeyFromPem:privateKeyPemForSign ifError:&error];
        _serverPublicKey = [DCPRSAKey publicKeyFromPem:publicKeyPemForEncrypt ifError:&error];
    }
    return self;
}

-(NSData*)decrypt:(DCPAPIEncryptedResponse*)encryptedResponse
{
    //1. verify signature
    NSMutableString* signToken = [NSMutableString new];
    [signToken appendString:encryptedResponse.cipher];
    [signToken appendString:encryptedResponse.key];
    [signToken appendString:encryptedResponse.iv];
    
//    NSLog(@"\rverify token:\r%@",signToken);
    
    NSData* dataForSign = [signToken dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* signatureFromServer = [NSData dataWithBase64EncodedString:encryptedResponse.signature];
    
    NSError* error = nil;
    BOOL verifyRet = [DCPRSA verifyWithSHA256:dataForSign withSignature:signatureFromServer withKey:_serverPublicKey ifError:&error];
    if(!verifyRet)
    {
        NSLog(@"decrypt fail,verify fail");
        return nil;
    }
    //2. rsa decrypt key
    NSData* keyCipherData = [NSData dataWithBase64EncodedString:encryptedResponse.key];
    
    NSData* keyPlainData = [DCPRSA decryptData:keyCipherData withKey:_appPrivateKey ifError:&error];
    if(keyPlainData == nil)
    {
        NSLog(@"decrypt fail,aes key decrypted fail");
        return nil;
    }
//    NSString* keyPlainBase64 = [keyPlainData base64EncodedString];
//    NSLog(@"\rkeyCipherBase64:\r%@",keyPlainBase64);
    //3. aes decrypt cipher
    
    NSData* ivData = [NSData dataWithBase64EncodedString:encryptedResponse.iv];
    NSData* cipherData = [NSData dataWithBase64EncodedString:encryptedResponse.cipher];
    
    NSData* plainData = [DCPAES AES256Decrypt:cipherData withKey:keyPlainData withIV:ivData];
    
    return plainData;
}

/**
 加密,获取key、iv和cihper
 */
-(DCPAPIEncryptResult*)encrypt:(NSData*)plainData
{
    //1. random aes 256 key
    NSData* aesKey = [DCPAES randomKeyForSize:DCPAESSize256];
//    NSString* aesKeyBase64=[aesKey base64EncodedString];
//    NSLog(@"\raesKeyBase64:\r%@\r\r",aesKeyBase64);
    //2. random aes iv
    NSData* iv = [DCPAES randomIVForSize:DCPAESSize256];
    
    //3. aes 256 encrypted the plain
    NSData* cipherData = [DCPAES AES256Encrypt:plainData withKey:aesKey withIV:iv];
    
    //4. encrypt the aes key
    NSError* error = nil;
    NSData* aesKeyCipherData = [DCPRSA encryptData:aesKey withKey:_serverPublicKey ifError:&error];
    if(error)
    {
        NSLog(@"DCPAPIEncryptor encrypt fail, AES KEY encrypted fail");
        return nil;
    }
    
    //5. sign the cipher
    NSString* aesKeyCipherBase64=[aesKeyCipherData base64EncodedString];
    NSString* ivBase64=[iv base64EncodedString];
    NSString* cipherBase64=[cipherData base64EncodedString];
    
    NSMutableString* signToken = [NSMutableString new];
    [signToken appendString:cipherBase64];
    [signToken appendString:aesKeyCipherBase64];
    [signToken appendString:ivBase64];
    
//    NSLog(@"\rsignToken=\r%@\r",signToken);
    
    NSData* dataForSign = [signToken dataUsingEncoding:NSUTF8StringEncoding];
    NSData* signature = [DCPRSA signWithSHA256:dataForSign withKey:_appPrivateKey ifError:&error];
    
    if(error)
    {
        NSLog(@"DCPAPIEncryptor encrypt fail, RSA sign encrypted fail");
        return nil;
    }
    NSString* signatureBase64 = [signature base64EncodedString];
    
    //6. struct the result
    DCPAPIEncryptResult* result = [DCPAPIEncryptResult new];
    
    result.cipher = cipherBase64;
    result.iv = ivBase64;
    result.key = aesKeyCipherBase64;
    result.signature = signatureBase64;
    
    return result;
}


@end
