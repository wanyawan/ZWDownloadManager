//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWCommon.h"


@interface ZWFileDownloadingInfo : NSObject

@property(nonatomic, strong)NSString *fileId;
@property(nonatomic, strong)NSString *fileTitle;            //title
@property(nonatomic, strong)NSString *fileDownloadUrl;
@property(nonatomic, strong)NSString *fileUUID;              //可以使用UUID存在文件系统和数据库中
@property(nonatomic, strong)NSData *resumeData;
@property(nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
@property(nonatomic, assign)float downloadBytes;
@property(nonatomic, assign)float totalBytes;
@property(nonatomic, assign)float progress;
@property(nonatomic, assign)ZWDownloadProgressType progressType;

@property(nonatomic, assign)float oldBytes;
@property(nonatomic, assign)float speed;
@property(nonatomic, assign)float showDownloadBytes;
@property(nonatomic, assign)float showTotalBytes;
@property(nonatomic, assign)float showSpeed;
@property(nonatomic, strong)NSDate *startDate;
@property(nonatomic, assign)ZWDownloadProgressType showProgressType;

+ (NSString *)getFilePath:(NSString *)fileUUID;
+ (NSString *)getTmpPath:(NSString *)fileUUID;
@end
