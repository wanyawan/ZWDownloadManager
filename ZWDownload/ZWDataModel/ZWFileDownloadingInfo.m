//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import "ZWFileDownloadingInfo.h"
#import "ZWTemporaryFileManger.h"
#import "ZWDownloadFileManger.h"

@implementation ZWFileDownloadingInfo
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setFileId:nil];
        [self setFileTitle:nil];
        [self setFileUUID:nil];
        [self setFileDownloadUrl:nil];
        [self setDownloadTask:nil];
        [self setResumeData:nil];
    }
    return self;
}

+ (NSString *)getFilePath:(NSString *)fileUUID
{
    NSString *type = [NSString stringWithFormat:@"%@%@",fileUUID,@".mp4"];   //下载完成后文件的类型 
    NSString *path = [[ZWDownloadFileManger fileDirPath]stringByAppendingPathComponent:type];
    return path;
}
+ (NSString *)getTmpPath:(NSString *)fileUUID
{
    NSString *tPath = [[ZWTemporaryFileManger temporaryDirPath] stringByAppendingPathComponent:fileUUID];
    return tPath;
}
@end
