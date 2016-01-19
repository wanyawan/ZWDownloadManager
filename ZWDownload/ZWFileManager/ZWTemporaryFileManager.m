//
//  ZWTemporaryFileManger.m
//  ZWDownloader
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ZWTemporaryFileManger.h"

@implementation ZWTemporaryFileManger
+ (BOOL)temporaryDirIsExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *TemporaryDirectory = [documentsDirectory stringByAppendingPathComponent:@"Temporary"];
    if ([fileManager fileExistsAtPath:TemporaryDirectory]) {
        //        NSLog(@"exist");
        return YES;
    }else{
        //        NSLog(@"not exist");
        return NO;
    }
}
+ (BOOL)mikTemporaryDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *TemporaryDirectory = [documentsDirectory stringByAppendingPathComponent:@"Temporary"];
    BOOL res = [fileManager createDirectoryAtPath:TemporaryDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"mkdir Temporary ZWccess");
        return YES;
    }else{
        NSLog(@"mkdir Temporary failure");
        return NO;
    }
}
+ (BOOL)deleteTemporaryDir
{
    if ([self temporaryDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *TemporaryDirectory = [documentsDirectory stringByAppendingPathComponent:@"Temporary"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL res = [fileManager removeItemAtPath:TemporaryDirectory error:nil];
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
+ (NSString *)temporaryDirPath
{
    if ([self temporaryDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *TemporaryDirectory = [documentsDirectory stringByAppendingPathComponent:@"Temporary"];
        //        NSLog(@"%@",TemporaryDirectory);
        return TemporaryDirectory;
    }else{
        return nil;
    }
}
@end
