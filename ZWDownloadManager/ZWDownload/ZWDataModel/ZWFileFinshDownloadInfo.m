//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//
#import "ZWFileFinshDownloadInfo.h"
#import "ZWTemporaryFileManager.h"
#import "ZWDownloadFileManager.h"
#import "ZWCommon.h"
@implementation ZWFileFinshDownloadInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setFileId:nil];
        [self setFileTitle:nil];
        [self setFileUUID:nil];
        [self setFileDownloadUrl:nil];
    }
    return self;
}
- (instancetype)initWithDownloadingInfo:(ZWFileDownloadingInfo *)info
{
    self = [self init];
    if (self) {
        [self setFileId:info.fileId];
        [self setFileTitle:info.fileTitle];
        [self setFileUUID:info.fileUUID];
        [self setFileDownloadUrl:info.fileDownloadUrl];
        [self setTotalBytes:info.totalBytes];
    }
    return self;
}
+ (NSString *)getFilePath:(NSString *)name
{
    NSString *type = [NSString stringWithFormat:@"%@%@",name,@".mp4"];
    NSString *path = [[ZWDownloadFileManager fileDirPath]stringByAppendingPathComponent:type];
    return path;
}
@end
