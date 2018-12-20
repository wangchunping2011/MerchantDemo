//
//  DCPBasicDataManager.m
//  DCPay
//
//  Created by zhanbin on 2018/4/11.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBasicDataManager.h"

@interface DCPBasicDataManager ()

@property (nonatomic, strong) DCPInitData* basicData;

@property (nonatomic, strong) NSMutableArray *blockArray;

// 行业数据
@property (nonatomic, strong) NSMutableArray *industryArray;
@end

@implementation DCPBasicDataManager

+ (instancetype )sharedInstance
{
    static dispatch_once_t once;
    static DCPBasicDataManager* _instance;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
        _instance.basicData = [_instance getInitDataFromFile];
    });
    return _instance;
}

-(NSMutableArray *)blockArray {
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

- (void)loadBasicData {

//    //获取初始化数据
//    [[DCPaySDKManager sharedInstance].basicDataService getInitDatasuccess:^(NSString *message, DCPInitData *data) {
//
//        if (data != nil) {
//            self->_basicData = data;
//            //保存文件
//            [self writeInitDataToFile:[data mj_keyValues]];
//        }
//        [self notifyBlock];
//    } failure:^(NSString *message, NSInteger code) {
//
//        [self notifyBlock];
//        [DCPReportErrorUtil reportError:@"获取初始化数据失败" errorCode:DCPReportErrorGetInitDataFail];
//    }];
    
    [self getIndustryData:nil];
}

- (void)getInitData:(DCPGetBasicDataBlock)block {
    if (_basicData) {
        block(_basicData);
    } else {
        [self.blockArray addObject:block];
        [self reloadData];
    }
}

- (void)reloadData {
    
    [self loadBasicData];
}

- (void)notifyBlock {
    for(int i = 0; i < self.blockArray.count; i++) {
        DCPGetBasicDataBlock block = self.blockArray[i];
        block(_basicData);
        
    }
}

/**
 获取行业数据

 @param success DCPIndustry数组
 */
- (void)getIndustryData:(void (^)(NSArray *datas))success {
    if (self.industryArray != nil && self.industryArray.count > 0) {
        if (success) {
            success(self.industryArray);
        }
        return;
    }
//    [[DCPaySDKManager sharedInstance].basicDataService getIndustryDatasuccess:^(NSString *message, NSArray *datas) {
//        self.industryArray = [NSMutableArray arrayWithArray:datas];
//        if (success) {
//            success(self.industryArray);
//        }
//    } failure:^(NSString *message, NSInteger code) {
//        if (success) {
//            success(self.industryArray);
//        }
//        [DCPReportErrorUtil reportError:@"获取行业数据失败" errorCode:DCPReportErrorGetIndustryDataFail];
//    }];
}

- (void)writeInitDataToFile:(NSDictionary *)initDataDict {
    
    NSString *initDataString = [NSString stringFromJSONData:initDataDict];
    [initDataString writeToFile:[self getFilePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (DCPInitData *)getInitDataFromFile {
    
    NSError *error = nil;
    NSString *initDataString = [NSString stringWithContentsOfFile:[self getFilePath] encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        NSDictionary *initDataDict = [NSString dictionaryWithJsonString:initDataString];
        return [DCPInitData mj_objectWithKeyValues:initDataDict];
    } else {
        return nil;
    }
}

- (NSString *)getFilePath {
    return [NSString stringWithFormat:@"%@/%@", [self getCachePath],@"initdata.txt"];
}

/**
 *  初始化缓存目录
 */
- (NSString *)getCachePath
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES) objectAtIndex:0];
    NSString *strCachePath = [documentsDirectory stringByAppendingPathComponent:@"cache"];
    //创建缓存文件夹
    NSError       *error;
    NSFileManager *fm         = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:strCachePath])
    {
        if (![fm createDirectoryAtPath:strCachePath
           withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"用户目录创建失败:%@", error);
        }
    }
    return strCachePath;
}

@end
