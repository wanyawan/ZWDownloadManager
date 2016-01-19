//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import "ZWDownloadQueueManger.h"
#import "ZWTemporaryFileManger.h"
#import "ZWURLSessionManger.h"
#import "ZWDownloadFileManger.h"
#import "AFNetworking.h"
#import "ZWURLSessionManger.h"
//#import "ZWVideoInfoSQLliteManger.h"
//#import "ZWNotificationCenter.h"
@interface ZWDownloadQueueManger ()

@property (strong, nonatomic, readonly) ZWFileDownloadingInfo *nextWaitDownloadinginfo;

@end

static ZWDownloadQueueManger *sharedInstance = nil;

@implementation ZWDownloadQueueManger

+ (ZWDownloadQueueManger *)sharedInstance
{
    static dispatch_once_t ZWDownloadQueueMangerOnceToken;
    dispatch_once(&ZWDownloadQueueMangerOnceToken,^{
        sharedInstance = [[[self class]alloc]init];
        [sharedInstance initDownloadArray];
    });
    return sharedInstance;
}

- (void)initDownloadArray
{
    _downloadinginfos = [[NSMutableArray alloc]init];
    _downloadedinfos = [[NSMutableArray alloc]init];
//    _downloadinginfos = [[[ZWVideoInfoSQLliteManger sharedInstance]getAllVideoDownloadingInfos]mutableCopy]; 后续版本加入数据库本地存储
    [self checkDownTaskCount];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
}

- (void)addDownloadTask:(ZWFileDownloadingInfo *)info
{
//    [[ZWVideoInfoSQLliteManger sharedInstance]addVideoDownloadingInfo:info];
    [_downloadinginfos addObject:info];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
    [self checkDownTaskCount];
}
- (void)deleteDownloadTask:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [_downloadinginfos objectAtIndex:index];
    switch (info.progressType) {
        case ZWDownloadProgressTypeDownloading:{
            [info.downloadTask cancel];
            info.downloadTask = nil;
            [_downloadinginfos removeObject:info];
//            [[ZWVideoInfoSQLliteManger sharedInstance]removeVideoDownloadingInfoByVideoUUID:info.videoUUID]; 后续版本加入数据库本地存储
            [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
        }break;
        case ZWDownloadProgressTypePause:{
            [_downloadinginfos removeObject:info];
//            [[ZWVideoInfoSQLliteManger sharedInstance]removeVideoDownloadingInfoByVideoUUID:info.videoUUID]; 后续版本加入数据库本地存储
            [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
        }break;
        case ZWDownloadProgressTypeWaiting:{
            [_downloadinginfos removeObject:info];
//            [[ZWVideoInfoSQLliteManger sharedInstance]removeVideoDownloadingInfoByVideoUUID:info.videoUUID]; 后续版本加入数据库本地存储
            [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
        }break;
        default:
            break;
    }
}
- (void)downloadFinsh:(ZWFileDownloadingInfo *)info
{
//    [[ZWVideoInfoSQLliteManger sharedInstance]removeVideoDownloadingInfoByVideoUUID:info.videoUUID]; 后续版本加入数据库本地存储
    ZWFileFinshDownloadInfo *finishInfo = [[ZWFileFinshDownloadInfo alloc]initWithDownloadingInfo:info];
    [_downloadedinfos addObject:finishInfo];
//    [[ZWVideoInfoSQLliteManger sharedInstance]addVideoFinshDownloadInfo:finishInfo]; 后续版本加入数据库本地存储
    [_downloadinginfos removeObject:info];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadingTableViewReloadData" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downloadedTableViewReloadData" object:nil];
    [self checkDownTaskCount];
}

- (NSInteger)downloadTaskCount
{
    return _downloadinginfos.count;
}

- (NSInteger)nextWaitDownloadinginfoIndex
{
    if (_downloadinginfos.count > 0) {
        for (int i = 0; i < _downloadinginfos.count; i ++) {
            ZWFileDownloadingInfo *info = [_downloadinginfos objectAtIndex:i];
            if (info.progressType == ZWDownloadProgressTypeWaiting) {
                return i;
            }
        }
    }
    return -1;
}

- (ZWFileDownloadingInfo *)nextWaitDownloadinginfo
{
    if (_downloadinginfos.count > 0) {
        for (int i = 0; i < _downloadinginfos.count; i ++) {
            ZWFileDownloadingInfo *info = [_downloadinginfos objectAtIndex:i];
            if (info.progressType == ZWDownloadProgressTypeWaiting) {
                return info;
            }
        }
    }
    return nil;
}
- (void)checkDownTaskCount
{
    int downloadingCount = 0;
    int waitingCount = 0;
    int pauseCount = 0;
    for (int i = 0; i < _downloadinginfos.count; i ++) {
        ZWFileDownloadingInfo *info = [_downloadinginfos objectAtIndex:i];
        switch (info.progressType) {
            case ZWDownloadProgressTypeDownloading:
                downloadingCount ++;
                break;
            case ZWDownloadProgressTypeWaiting:
                waitingCount ++;
                break;
            case ZWDownloadProgressTypePause:
                pauseCount ++;
                break;
            default:
                break;
        }
    }
    switch (downloadingCount) {
        case 0:
            [self nextWaitTaskReZWme];
            [self nextWaitTaskReZWme];
            [self nextWaitTaskReZWme];
            break;
        case 1:
            [self nextWaitTaskReZWme];
            [self nextWaitTaskReZWme];
            break;
        case 2:
            [self nextWaitTaskReZWme];
            break;
        default:
            
            break;
    }
}
- (void)nextWaitTaskReZWme
{
    if (self.nextWaitDownloadinginfo) {
        ZWFileDownloadingInfo *info = self.nextWaitDownloadinginfo;
        info.resumeData = [NSData dataWithContentsOfFile:[ZWFileDownloadingInfo getTmpPath:info.fileUUID] options:NSDataReadingMappedIfSafe error:nil];
        info.startDate = [NSDate date];
        info.oldBytes = 0;
        if (info.resumeData) {
            info.downloadTask = [[ZWURLSessionManger sharedInstance]downloadTaskWithResumeData:info.resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
                info.downloadBytes = downloadProgress.completedUnitCount;
                info.totalBytes = downloadProgress.totalUnitCount;
                NSDate *currentDate = [NSDate date];
                if ([currentDate timeIntervalSinceDate:info.startDate] >= 1) {
                    info.speed = (info.downloadBytes - info.oldBytes)/[currentDate timeIntervalSinceDate:info.startDate];
                    info.oldBytes = info.downloadBytes;
                    info.startDate = currentDate;
                }
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                info.progressType = ZWDownloadProgressTypeDownloadFinsh;
                info.downloadBytes = info.totalBytes;
                return [NSURL fileURLWithPath:[ZWFileDownloadingInfo getFilePath:info.fileUUID]];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                if (info.progressType == ZWDownloadProgressTypeDownloadFinsh)
                {
                    NSLog(@"%@",filePath);
                    [[ZWDownloadQueueManger sharedInstance]downloadFinsh:info];
                }
            }];
            
        }else{
            NSURL *url = [NSURL URLWithString:self.nextWaitDownloadinginfo.fileDownloadUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            info.downloadTask = [[ZWURLSessionManger sharedInstance]downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                info.downloadBytes = downloadProgress.completedUnitCount;
                info.totalBytes = downloadProgress.totalUnitCount;
                NSDate *currentDate = [NSDate date];
                if ([currentDate timeIntervalSinceDate:info.startDate] >= 1) {
                    info.speed = (info.downloadBytes - info.oldBytes)/[currentDate timeIntervalSinceDate:info.startDate];
                    info.oldBytes = info.downloadBytes;
                    info.startDate = currentDate;
                }
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                info.progressType = ZWDownloadProgressTypeDownloadFinsh;
                info.downloadBytes = info.totalBytes;
                return [NSURL fileURLWithPath:[ZWFileDownloadingInfo getFilePath:info.fileUUID]];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                if (info.progressType == ZWDownloadProgressTypeDownloadFinsh)
                {
                    NSLog(@"%@",filePath);
                    [[ZWDownloadQueueManger sharedInstance]downloadFinsh:info];
                }
            }];
        }
        [info.downloadTask resume];
        info.progressType = ZWDownloadProgressTypeDownloading;
    }
}

- (void)ZWspendTask:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [self.downloadinginfos objectAtIndex:index];
    [info.downloadTask suspend];
    info.progressType = ZWDownloadProgressTypePause;
}

- (void)cancel:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [self.downloadinginfos objectAtIndex:index];
    [info.downloadTask cancel];
    info.downloadTask = nil;
    [_downloadinginfos removeObject:info];
}
- (void)pause:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [self.downloadinginfos objectAtIndex:index];
    [info.downloadTask cancelByProducingResumeData:^(NSData * _Nullable reZWmeData) {
        NSData *tmpData = [reZWmeData copy];
        info.progressType = ZWDownloadProgressTypePause;
        if (tmpData == nil) {
            
        }else
        {
            NSURL *tmpPath = [NSURL fileURLWithPath:[ZWFileDownloadingInfo getTmpPath:info.fileUUID]];
            [tmpData writeToURL:tmpPath options:NSDataWritingAtomic error:nil];
            info.downloadTask = nil;
        }
//        [[ZWVideoInfoSQLliteManger sharedInstance]updateVideoDownloadingInfo:info]; 后续版本加入数据库本地存储
    }];
    
    [self nextWaitTaskReZWme];
}

- (ZWDownloadProgressType)progressType:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [self.downloadinginfos objectAtIndex:index];
    return info.progressType;
}
- (void)terminate
{
//    __weak ZWDownloadQueueManger *weakSelf = self;
    [_downloadinginfos enumerateObjectsUsingBlock:^(ZWFileDownloadingInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.progressType == ZWDownloadProgressTypeDownloading) {
            [[ZWDownloadQueueManger sharedInstance] pause:idx];
        }
    }];
}
- (void)appWillTerminatePauseTask:(NSInteger)index
{
    ZWFileDownloadingInfo *info = [self.downloadinginfos objectAtIndex:index];
    [info.downloadTask cancelByProducingResumeData:^(NSData * _Nullable reZWmeData) {
        NSData *tmpData = [reZWmeData copy];
        info.progressType = ZWDownloadProgressTypeWaiting;
        if (tmpData == nil) {
            
        }else
        {
            NSURL *tmpPath = [NSURL fileURLWithPath:[ZWFileDownloadingInfo getTmpPath:info.fileUUID]];
            [tmpData writeToURL:tmpPath options:NSDataWritingAtomic error:nil];
            info.downloadTask = nil;
        }
    }];
}

@end
