//
//  ZWDatabaseFileManger.m
//  ZWDownloader
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ZWDatabaseFileManager.h"

@implementation ZWDatabaseFileManager
+ (BOOL)databaseDirIsExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *DatabaseDirectory = [documentsDirectory stringByAppendingPathComponent:@"Database"];
    if ([fileManager fileExistsAtPath:DatabaseDirectory]) {
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)mikDatabaseDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *DatabaseDirectory = [documentsDirectory stringByAppendingPathComponent:@"Database"];
    BOOL res = [fileManager createDirectoryAtPath:DatabaseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"mkdir Database ZWccess");
        return YES;
    }else{
        NSLog(@"mkdir Database failure");
        return NO;
    }
}
+ (BOOL)deleteDatabaseDir
{
    if ([self databaseDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *DatabaseDirectory = [documentsDirectory stringByAppendingPathComponent:@"Database"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL res = [fileManager removeItemAtPath:DatabaseDirectory error:nil];
        if (res) {
            NSLog(@"delete ZWccess");
            return YES;
        }else
        {
            NSLog(@"delete failure");
            return NO;
        }
    }else
    {
        return NO;
    }
}
+ (NSString *)databaseDirPath
{
    if ([self databaseDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *DatabaseDirectory = [documentsDirectory stringByAppendingPathComponent:@"Database"];
        return DatabaseDirectory;
    }else{
        return nil;
    }
}
@end
