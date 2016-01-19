//
//  ZWVideoFileManger.m
//  ZWDownloader
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ZWDownloadFileManger.h"

@implementation ZWDownloadFileManger
+ (BOOL)fileDirIsExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *VideoDirectory = [documentsDirectory stringByAppendingPathComponent:@"Video"];
    if ([fileManager fileExistsAtPath:VideoDirectory]) {
//        NSLog(@"exist");
        return YES;
    }else{
//        NSLog(@"not exist");
        return NO;
    }
}
+ (BOOL)mikFileDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *VideoDirectory = [documentsDirectory stringByAppendingPathComponent:@"Video"];
    BOOL res = [fileManager createDirectoryAtPath:VideoDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"mkdir Video ZWccess");
        return YES;
    }else{
        NSLog(@"mkdir Video failure");
        return NO;
    }
}
+ (BOOL)deleteFileDir
{
    if ([self fileDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *VideoDirectory = [documentsDirectory stringByAppendingPathComponent:@"Video"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL res = [fileManager removeItemAtPath:VideoDirectory error:nil];
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
+ (NSString *)fileDirPath
{
    if ([self fileDirIsExist]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *VideoDirectory = [documentsDirectory stringByAppendingPathComponent:@"Video"];
        return VideoDirectory;
    }else{
        return nil;
    }
}
@end
