//
//  DCPAES.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAES.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation DCPAES

+(NSData*)randomKeyForSize:(DCPAESSize)size
{
    NSUInteger keySize = [self keySize:size];
    
    NSMutableData* key = [NSMutableData dataWithLength:keySize];
    int ret = SecRandomCopyBytes(kSecRandomDefault, key.length, (uint8_t *)key.mutableBytes);
    if( ret == 0)
        return key;
    else
        return nil;
    return key;
}


+(NSData*)randomIVForSize:(DCPAESSize)size
{
    NSUInteger keySize = 16;
    
    NSMutableData* iv = [NSMutableData dataWithLength:keySize];
    int ret = SecRandomCopyBytes(kSecRandomDefault, iv.length, (uint8_t *)iv.mutableBytes);
    
    if( ret == 0)
        return iv;
    else
        return nil;
    return iv;
}

+(BOOL) checkKey:(NSData*)key forSize:(DCPAESSize)size
{
    uint32_t keySize = kCCKeySizeAES256;
    switch (size) {
        case DCPAESSize128:
            keySize = kCCKeySizeAES128;
            break;
        case DCPAESSize192:
            keySize = kCCKeySizeAES192;
            break;
        case DCPAESSize256:
            keySize = kCCKeySizeAES256;
            break;
    }
    
    return keySize==key.length;
}

+(NSUInteger)keySize:(DCPAESSize)size
{
    NSUInteger keySize = kCCKeySizeAES256;
    switch (size) {
        case DCPAESSize128:
            keySize = kCCKeySizeAES128;
            break;
        case DCPAESSize192:
            keySize = kCCKeySizeAES192;
            break;
        case DCPAESSize256:
            keySize = kCCKeySizeAES256;
            break;
    }
    return keySize;
}

+ (NSData *)encryptData:(NSData*)plainData forSize:(DCPAESSize)size withKey:(NSData *)key withIV:(NSData*)iv needPadding:(BOOL)padding
{
    if(![self checkKey:key forSize:size])
    {
        NSLog(@"encryptData fail,key not fit the size");
        return nil;
    }
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    NSUInteger keySize = [self keySize:size];
    // room for terminator (unused)
    char keyPtr[keySize+1];
    // fill with zeroes (for padding)
    bzero(keyPtr, sizeof(keyPtr));
    memcpy(keyPtr, key.bytes, keySize);
    
    NSUInteger dataLength = [plainData length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, padding?kCCOptionPKCS7Padding:0,
                                          keyPtr, keySize,
                                          iv?iv.bytes:NULL /* initialization vector (optional) */,
                                          [plainData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+ (NSData *)decryptData:(NSData*)cipherData forSize:(DCPAESSize)size withKey:(NSData *)key withIV:(NSData*)iv needPadding:(BOOL)padding
{
    if(![self checkKey:key forSize:size])
    {
        NSLog(@"encryptData fail,key not fit the size");
        return nil;
    }
    NSUInteger keySize = [self keySize:size];
    char keyPtr[keySize+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    memcpy(keyPtr, key.bytes, keySize);
    // fetch key data
    //[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [cipherData length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, padding?kCCOptionPKCS7Padding:0,
                                          keyPtr, keySize,
                                          iv?iv.bytes:NULL /* initialization vector (optional) */,
                                          [cipherData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    //free the buffer;
    free(buffer);
    return nil;
}

#pragma mark - AES256

+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key
{
    return [self AES256Encrypt:plainData withKey:key withIV:nil needPadding:YES];
}
+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key withIV:(NSData*)iv
{
    return [self AES256Encrypt:plainData withKey:key withIV:iv needPadding:YES];
}
+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key withIV:(NSData*)iv needPadding:(BOOL)padding
{
    return [self encryptData:plainData forSize:DCPAESSize256 withKey:key withIV:iv needPadding:padding];
}

+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key
{
    return [self AES256Decrypt:cipherData withKey:key withIV:nil needPadding:YES];
}
+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key withIV:(NSData*)iv
{
    return [self AES256Decrypt:cipherData withKey:key withIV:iv needPadding:YES];
}
+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key withIV:(NSData*)iv needPadding:(BOOL)padding
{
    return [self decryptData:cipherData forSize:DCPAESSize256 withKey:key withIV:iv needPadding:padding];
}



@end
