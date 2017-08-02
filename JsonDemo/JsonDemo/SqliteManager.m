//
//  SqliteManager.m
//  JsonDemo
//
//  Created by DengHengyu on 2017/8/2.
//  Copyright © 2017年 YunJing. All rights reserved.
//

#import "SqliteManager.h"

static sqlite3 *_db = nil;
 static SqliteManager *_manager = nil;
@implementation SqliteManager

+ (SqliteManager *)shareManager
{
   
    if (_manager == nil) {
        _manager = [[SqliteManager alloc] init];
    }
    return _manager;
}


- (sqlite3 *)openDB {
    if (_db != nil) {
        return _db;
    }
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CityInfo.sqlite"];
    NSLog(@"dbPath=======%@",dbPath);
    if (sqlite3_open(dbPath.UTF8String, &_db) == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
       NSLog(@"打开数据库失败");
    }
    return _db;
}

- (void)closeDB {
    if (sqlite3_close(_db) == SQLITE_OK) {
        _db = nil;
          NSLog(@"关闭数据库成功");
    } else {
      NSLog(@"关闭数据库失败");
    }
}

- (void)createTable {
    
    NSString *sql = [NSString stringWithFormat:@"create table IF NOT EXISTS ChinaCityInfo(ID integer primary key not NULL,name text not NULL,parent_id integer, level integer, filter_sort integer, firstchar text, is_filter_view integer)"];
    
    [_manager executeNonQuery:sql];
}

- (void)executeNonQuery:(NSString *)sql {
    _db = [_manager openDB];
    char *error;
    
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error) != SQLITE_OK) {
         NSLog(@"执行SQL语句过程中发生错误！错误信息：%s",error);
    } else {
        NSLog(@"执行SQL语句成功");
    }
    [_manager closeDB];
}

@end
