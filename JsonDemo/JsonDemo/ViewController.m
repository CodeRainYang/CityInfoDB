//
//  ViewController.m
//  JsonDemo
//
//  Created by DengHengyu on 2017/8/2.
//  Copyright © 2017年 YunJing. All rights reserved.
//

#import "ViewController.h"
#import "SqliteManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self writeShengIngoToDB];
    [self writeShiIngoToDB];
    [self writeXianIngoToDB];
}


- (void)writeShengIngoToDB {
    NSString *shengPath  =  [[NSBundle mainBundle] pathForResource:@"sheng" ofType:@"json"];
    NSLog(@"shengPath = %@",shengPath);
    NSData *shengData = [NSData dataWithContentsOfFile:shengPath];
    NSArray *shengArr = [NSJSONSerialization JSONObjectWithData:shengData options:NSJSONReadingMutableContainers error:nil];
    
    NSString *shengStr = [[NSString alloc] initWithData:shengData encoding:NSUTF8StringEncoding];
    
    NSLog(@"shengStr = %@",shengStr );
    [[SqliteManager shareManager] createTable];
    
    for (NSDictionary *shengDict in shengArr) {
        NSString *shengSql = [NSString stringWithFormat:@"insert into ChinaCityInfo(name, ID, level) values('%@', '%ld', '1')",shengDict[@"name"],[shengDict[@"id"] integerValue]];
        [[SqliteManager shareManager] executeNonQuery:shengSql];
    }
    
}

- (void)writeShiIngoToDB {
    NSString *shiPath  =  [[NSBundle mainBundle] pathForResource:@"shi" ofType:@"json"];
    NSLog(@"shiPath = %@",shiPath);
    NSData *shiData = [NSData dataWithContentsOfFile:shiPath];
    NSArray *shiArr = [NSJSONSerialization JSONObjectWithData:shiData options:NSJSONReadingMutableContainers error:nil];
    
    NSString *shiStr = [[NSString alloc] initWithData:shiData encoding:NSUTF8StringEncoding];
    
    NSLog(@"shiStr = %@",shiStr );
//    [[SqliteManager shareManager] createTable];
    
    for (NSDictionary *shiDict in shiArr) {
        NSString *shiSql = [NSString stringWithFormat:@"insert into ChinaCityInfo(name, ID, level, parent_id, firstchar) values('%@', '%ld', '2', '%ld', '%@')",shiDict[@"name"],[shiDict[@"id"] integerValue], [shiDict[@"parent_id"] integerValue], shiDict[@"firstchar"]];
        [[SqliteManager shareManager] executeNonQuery:shiSql];
    }
    
}

- (void)writeXianIngoToDB {
    NSString *xianPath  =  [[NSBundle mainBundle] pathForResource:@"xian" ofType:@"json"];
    NSLog(@"xianPath = %@",xianPath);
    NSData *xianData = [NSData dataWithContentsOfFile:xianPath];
    NSArray *xianArr = [NSJSONSerialization JSONObjectWithData:xianData options:NSJSONReadingMutableContainers error:nil];
    
    NSString *xianStr = [[NSString alloc] initWithData:xianData encoding:NSUTF8StringEncoding];
    
    NSLog(@"xianStr = %@",xianStr );
//    [[SqliteManager shareManager] createTable];
    
    for (NSDictionary *xianDict in xianArr) {
        NSString *xianSql =  [NSString stringWithFormat:@"insert into ChinaCityInfo(name, ID, level, parent_id, firstchar) values('%@', '%ld', '3', '%ld', '%@')",xianDict[@"name"],[xianDict[@"id"] integerValue], [xianDict[@"parent_id"] integerValue], xianDict[@"firstchar"]];
        [[SqliteManager shareManager] executeNonQuery:xianSql];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
