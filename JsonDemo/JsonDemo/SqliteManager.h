//
//  SqliteManager.h
//  JsonDemo
//
//  Created by DengHengyu on 2017/8/2.
//  Copyright © 2017年 YunJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteManager : NSObject

+(SqliteManager *)shareManager;

- (sqlite3 *)openDB;

- (void)closeDB;

- (void)createTable;

- (void)executeNonQuery:(NSString *)sql;

@end
