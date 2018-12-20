//
//  DCPAES.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DCPAESSize128,
    DCPAESSize192,
    DCPAESSize256
} DCPAESSize;

@interface DCPAES : NSObject

+(NSData*)randomKeyForSize:(DCPAESSize)size;
+(NSData*)randomIVForSize:(DCPAESSize)size;

+ (NSData *)encryptData:(NSData*)plainData forSize:(DCPAESSize)size withKey:(NSData *)key withIV:(NSData*)iv needPadding:(BOOL)padding;

+ (NSData *)decryptData:(NSData*)cipherData forSize:(DCPAESSize)size withKey:(NSData *)key withIV:(NSData*)iv needPadding:(BOOL)padding;


#pragma mark - AES256

+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key;
+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key withIV:(NSData*)iv;
+(NSData*) AES256Encrypt:(NSData*)plainData withKey:(NSData*)key withIV:(NSData*)iv needPadding:(BOOL)padding;

+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key;
+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key withIV:(NSData*)iv;
+(NSData*) AES256Decrypt:(NSData*)cipherData withKey:(NSData*)key withIV:(NSData*)iv needPadding:(BOOL)padding;

@end
