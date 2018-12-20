//
//  DCPFileManager.m
//  DCPay
//
//  Created by autoround-032 on 2018/4/19.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPFileManager.h"

@implementation DCPFileManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id _instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    
    return _instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self filePathInitialization];
    }
    
    return self;
}

-(void)filePathInitialization
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    
    _accountListFile = [documentsPath stringByAppendingPathComponent:@"account.plist"];
    
    _erc20ForceListFile   = [[documentsPath stringByAppendingPathComponent:@"erc20ForceList"]stringByAppendingPathExtension:@"plist"];
    
    _erc20NormalListFile   = [[documentsPath stringByAppendingPathComponent:@"erc20NormalListFile"]stringByAppendingPathExtension:@"plist"];
    
    _allCoinListFile = [[documentsPath stringByAppendingPathComponent:@"allCoinListFile"]stringByAppendingPathExtension:@"plist"];

}

@end
