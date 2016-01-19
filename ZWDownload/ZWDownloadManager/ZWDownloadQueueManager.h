//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWFileDownloadingInfo.h"
#import "ZWFileFinshDownloadInfo.h"
@interface ZWDownloadQueueManger : NSObject
@property (nonatomic, strong)NSMutableArray <ZWFileDownloadingInfo *> *downloadinginfos;
@property (nonatomic, strong)NSMutableArray <ZWFileFinshDownloadInfo *> *downloadedinfos;
+ (ZWDownloadQueueManger *)sharedInstance;
- (void)addDownloadTask:(ZWFileDownloadingInfo *)info;
- (void)downloadFinsh:(ZWFileDownloadingInfo *)info;
- (void)deleteDownloadTask:(NSInteger)index;
- (NSInteger)downloadTaskCount;
- (void)checkDownTaskCount;
- (void)nextWaitTaskReZWme;
- (void)ZWspendTask:(NSInteger)index;
- (void)cancel:(NSInteger)index;
- (void)pause:(NSInteger)index;
- (void)terminate;

@end
