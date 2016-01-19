//
//  ZWVideoFileManger.h
//  ZWDownloader
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWDownloadFileManager : NSObject
+ (BOOL)fileDirIsExist;
+ (BOOL)mikFileDir;
+ (BOOL)deleteFileDir;
+ (NSString *)fileDirPath;

@end
