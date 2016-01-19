//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWFileDownloadingInfo.h"
@interface ZWFileFinshDownloadInfo : NSObject
@property (nonatomic, strong)NSString *fileId;          //id
@property (nonatomic, strong)NSString *fileTitle;            //title

@property(nonatomic, strong)NSString *fileUUID;
@property(nonatomic, strong)NSString *fileDownloadUrl;
@property(nonatomic, assign)float totalBytes;

- (instancetype)initWithDownloadingInfo:(ZWFileDownloadingInfo *)info;
+ (NSString *)getFilePath:(NSString *)name;
@end
