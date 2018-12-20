//
//  DCPAddressManager.m
//  DCPay
//
//  Created by 詹斌 on 2018/4/15.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPAddressManager.h"
#import <FMDB/FMDB.h>

static const NSString* const addressDbName = @"dcp_address.db";

@interface DCPAddressManager()

@property (nonatomic, strong) FMDatabaseQueue *queue;


@end

@implementation DCPAddressManager

+ (instancetype )sharedInstance
{
    static dispatch_once_t once;
    static DCPAddressManager* _instance;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
        [_instance setupAddressDb];
    });
    return _instance;
}

- (void)setupAddressDb {
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [queue inDatabase:^(FMDatabase *db) {
        
        //用户基本信息表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_address_info ("
         "id integer NOT NULL PRIMARY KEY AUTOINCREMENT, "
         "nick_name text,"
         "first_letter text,"
         "address text);"];
    }];
    
    [queue close];
}

- (NSString *)getDbPath {
    return [NSString stringWithFormat:@"%@/%@", [self getCachePath],addressDbName];
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

- (NSArray<DCPAddressInfo *> *)getAllAddress {
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 1.定义数组
    __block NSMutableArray *addressArray = nil;
    
    // 2.使用数据库
    [queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        addressArray = [NSMutableArray array];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_address_info"];
        while ([rs next])
        {
            DCPAddressInfo *addressInfo = [self pickAddressFromDB:rs];
            [addressArray addObject:addressInfo];
        }
        [rs close];
    }];
    //关闭数据库
    [queue close];
    
    return addressArray;
}

/**
 *  根据SQL查询结构FMResultSet,构造WCUserHead
 */
-(DCPAddressInfo *)pickAddressFromDB:(FMResultSet*)rs
{
    DCPAddressInfo *addressInfo = nil;
    @try
    {
        addressInfo = [[DCPAddressInfo alloc] init];
        addressInfo.addressId           = [rs longForColumn:@"id"];
        addressInfo.nickName            = [rs stringForColumn:@"nick_name"];
        addressInfo.firstLetter         = [rs stringForColumn:@"first_letter"];
        addressInfo.address             = [rs stringForColumn:@"address"];
        return addressInfo;
    }
    @catch (NSException *exception)
    {
        return nil;
    }
    
}

- (BOOL)addAddress:(DCPAddressInfo *)addressInfo {
    
    __block BOOL isOK = NO;
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [queue inDatabase:^(FMDatabase *db) {
        //之前没有存该用户的基本数据
        isOK = [db executeUpdate:@"INSERT INTO t_address_info (nick_name, first_letter, address) values (?,?,?)",
                 addressInfo.nickName,
                 addressInfo.firstLetter,
                 addressInfo.address];
    }];
    
    //关闭数据库
    [queue close];
    
    return isOK;
}


/**
 是否存在相同昵称的地址
 */
- (BOOL)isExistSameNickName:(NSString *)nickName{
    __block NSInteger count = NO;
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [queue inDatabase:^(FMDatabase *db) {
        //之前是否存在该nickName的地址
        count = [db intForQuery:@"select count(*) from t_address_info where nick_name = ?",nickName];
    }];
    
    //关闭数据库
    [queue close];
    
    return count > 0 ? YES : NO;
}

/**
 是否存在相同地址
 */
- (BOOL)isExistSameAddress:(NSString *)address{
    __block NSInteger count = NO;
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [queue inDatabase:^(FMDatabase *db) {
        //之前是否存在该nickName的地址
        count = [db intForQuery:@"select count(*) from t_address_info where address = ?",address];
    }];
    
    //关闭数据库
    [queue close];
    
    return count > 0 ? YES : NO;
}

- (BOOL)delAddress:(NSInteger)addressId {
    
    __block BOOL isOK = NO;
    // 0.获得沙盒中的数据库文件名
    NSString *path = [self getDbPath];
    // 1.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        isOK = [db executeUpdate:@"DELETE FROM t_address_info WHERE id = ?",[NSNumber numberWithInteger:addressId]];
    }];
    
    //关闭数据库
    [queue close];
    
    return isOK;
}

- (void)modifyAddress:(DCPAddressInfo *)address {
    
}

@end
