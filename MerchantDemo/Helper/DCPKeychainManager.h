//
//  DCPKeychainManager.h
//  DCPay
//
//  Created by sean on 2018/5/16.
//  Copyright © 2018 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPKeychainManager : NSObject
+(instancetype)sharedInstance;
-(void)manager;
@end
